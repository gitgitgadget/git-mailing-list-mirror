From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Fri, 26 Mar 2010 17:40:39 -0500
Message-ID: <20100326224038.GA18454@progeny.tock>
References: <20100326215600.GA10910@spearce.org>
 <20100326222659.GA18369@progeny.tock>
 <20100326222950.GB10910@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, mike.lifeguard@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 26 23:40:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvICh-0007fF-1c
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 23:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390Ab0CZWk3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Mar 2010 18:40:29 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:60637 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754217Ab0CZWk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 18:40:28 -0400
Received: by ywh2 with SMTP id 2so3816317ywh.33
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 15:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VGllBqk0wisvmwVSZAgkHP+lUVLJ1UCAgWWAuPSDuu8=;
        b=eaXE54qQomtxn4yqtJuEP3o5X3ZDEoht0gGAIpFTeV3IDHuMNxAqA/cVybajia0DWw
         vAecOyfPvOpT6Gix16zgiv4wFFjA4LAftztC6pFgBeZ1COZoG2kaVsVp70JLO6eZigoD
         5pJIqGAzPIHzgX9Az5CTrsoZbH6vn2WXXyYQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LxHDRlHgOwB57H5Qghaxf0OvfSJak4R/sYsgVE8cAENfLcIHwJwqHVPI3Od5xKENie
         l3dcZJTGnsJ33DRCRM+i5p7rU/72I2D0KYn8Dq0b/y8SGvROHdU/T/Okqn44ilyoI+vH
         fLclVAL9kzWzsQoh87zh3fWFimod8QEBDS+HE=
Received: by 10.150.160.9 with SMTP id i9mr2196259ybe.243.1269643226881;
        Fri, 26 Mar 2010 15:40:26 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm1173288iwn.7.2010.03.26.15.40.25
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 26 Mar 2010 15:40:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100326222950.GB10910@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143292>

Shawn O. Pearce wrote:
> Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Shawn O. Pearce wrote:

>>> Any ideas?  Why is Git 1.7.0.3 jamming a leading '0' on a file mode=
?
>>=20
>> See http://thread.gmane.org/gmane.comp.version-control.git/141028
>> and commit c88f0cc (notes: fix malformed tree entry, 2010-02-24).
>>=20
>> The regression that that fixes appeared in 61a7cca0 (Notes API:
>> write_notes_tree(): Store the notes tree in the database, 2010-02-13=
),
>> which is not part of 1.7.0.3.
>
> That may be true... but I doubt the tree in question was a notes
> tree.  The path entries were names like 'README', 'modules' and
> 'stewardbot'.  Something I would assume was the project's source
> tree, not its notes tree.

Yes, true.  The problem is probably elsewhere, especially because
1.7.0.3 doesn=E2=80=99t even have that commit.  Still, I find this a bi=
t
strange because such breakage should have been noticeable if it
happens often.

What has changed recently that involves writing trees?

Jonathan
