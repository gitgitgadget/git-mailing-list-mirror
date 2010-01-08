From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH 0/2] Support relative .git file in a submodule
Date: Fri, 8 Jan 2010 18:24:13 -0500
Message-ID: <32541b131001081524g43d54a44i582dd286c1dfe7a5@mail.gmail.com>
References: <1262990208-15554-1-git-send-email-brad.king@kitware.com> 
	<7vocl4urc6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brad King <brad.king@kitware.com>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 00:24:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTOCA-00015h-KA
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 00:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216Ab0AHXYi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jan 2010 18:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754206Ab0AHXYi
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 18:24:38 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:48766 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564Ab0AHXYh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 18:24:37 -0500
Received: by ywh6 with SMTP id 6so19963420ywh.4
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 15:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=2VMi5vz4YgGgLa+yGFYURipfXpN2/s+1KEjV0WXbWNs=;
        b=pGaC1pKL9g/UzC6i3KuCdYnTaPoAukfFt3UecCK3NzyfH6psb4XKpFnNH7EwKGyPBx
         QuH2H5ZvRI7R0O74b03wQDV4u2Y0edYEMRpCNglHtLg/Zhh4GZjqMIcwJXy0ncKsepVj
         OSRluDny6SEGP57Kalb2stRlXuG4iVKq7ppO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=MTv8uYyMAITV/coo5Opp9PgBJKyQlc6o5+twwWsH+9uMq0iil7sTRF7oOk1CZqcMom
         5XXT3DDdqQO8C8A1f/L18NY7AV4iqcMJmX4MH7PzHO+ERIa5KfDW4zpGkLD0joitB/G2
         dwe/pbVx7/qjbS+ZCxX1yj51yS/ge8RiSK6bg=
Received: by 10.150.174.8 with SMTP id w8mr1629261ybe.204.1262993075331; Fri, 
	08 Jan 2010 15:24:35 -0800 (PST)
In-Reply-To: <7vocl4urc6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136495>

On Fri, Jan 8, 2010 at 6:09 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Brad King <brad.king@kitware.com> writes:
>
>> ... if a submodule
>> has a .git file "symlink" with a relative path to the real submodule
>> repository then ...
>
> ... then I've always thought that is simply a misconfiguration (t0002
> seems to use full path for this exact reason). =A0Is there a reason w=
hy
> relative path should be used/usable here, other than "being able to i=
s
> better than not being able to"???

If I have a bunch of git repos in ~/src, and I decide I'd rather
rename it all to ~/source, it seems like it would be nice for all my
links not to be broken.  This sort of thing can also happen if you
have NFS-mounted home directories on a farm of machines, and some of
them automount in /u/username and others use /home/username, for
example.  I think this is the same reason that common sysadmin advice
is to use relative symlinks instead of absolute links.

This problem seems especially true with submodules.  If the
submodule's repo is something like supermodule/.git/submodule.git, a
relative path would almost always be a appropriate, no?

Have fun,

Avery
