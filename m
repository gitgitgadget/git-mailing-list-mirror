From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git as backup and file sync system
Date: Fri, 2 Apr 2010 15:49:53 -0400
Message-ID: <j2v32541b131004021249s738a06cfq2804b97f798ac482@mail.gmail.com>
References: <m2q5f14cf5e1004021216y60797d29j1f63092435998823@mail.gmail.com> 
	<k2mfabb9a1e1004021235xc75e25a8na941c1754fd543c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: turner25@gmail.com, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 21:50:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxmsn-0001r5-5I
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 21:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601Ab0DBTuQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 15:50:16 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50193 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab0DBTuO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 15:50:14 -0400
Received: by gwb19 with SMTP id 19so311654gwb.19
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 12:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=UeWo8+v3lY3M7fntjUrj1PcTSaaMTMItiu968afJLv4=;
        b=Qn/c0I5ntmS7tFzocgGiD+4Q7hfY3QQJgtwRYXjFzHrpSbxybJ6QHUdK1eC2NykesF
         vfkY6zJVkhT+3FtP/khkv/tVhsz9nqLU6nwtObclN7RQLvej0Da/SKXXqLerAK04eCdg
         JbFyUKa3T0AEv4tBXbSNfEHo6G4vZvr2oU+wI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gRo8ErWZHP0NEpKH4fz8S+kxivRJOKITva+HZt4zUhgk2zGSODOWo5BGpm3zdsP00h
         8zKOIy/cymadG2AfOzEJzLaiMSePL23JIaxSfMg5QGPDATkGw/fklt7SzSvIQjy06Kfo
         8TW6MMfWPbSepoNDtvNEdmHDigjUk8+ojyuj4=
Received: by 10.150.186.6 with HTTP; Fri, 2 Apr 2010 12:49:53 -0700 (PDT)
In-Reply-To: <k2mfabb9a1e1004021235xc75e25a8na941c1754fd543c@mail.gmail.com>
Received: by 10.151.60.7 with SMTP id n7mr3367093ybk.183.1270237813084; Fri, 
	02 Apr 2010 12:50:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143845>

On Fri, Apr 2, 2010 at 3:35 PM, Sverre Rabbelier <srabbelier@gmail.com>=
 wrote:
> On Fri, Apr 2, 2010 at 13:16, Simon <turner25@gmail.com> wrote:
>> =A0I'm not sure if this post will be very welcome, but I'd like your
>> feedback or suggestions. =A0I've been reading Jon Loeliger's book ab=
out
>> git and I've understood many many things. =A0I'm interested in using=
 git
>> as a backup and sync system between computers.
>
> You might want to look into 'bup', [0] designed specifically for that
> purpose. It seems like introduction post about it on apenwarr.ca is
> down though [1].
>
> [0] http://github.com/apenwarr/bup
> [1] http://apenwarr.ca/log/?m=3D201001#04

Yeah, sorry, apenwarr.ca is flakey at the best of times.  It takes afte=
r me :)

Disclaimer: bup does lots of neat backup-related stuff, but it doesn't
*yet* support detailed metadata.  We're working on it:
http://groups.google.com/group/bup-list/browse_thread/thread/e899a579a6=
f7ae55

If you're only storing a relatively small number of files (say /etc),
then something like etckeeper might do what you want.  Or more
generally, metastore (which etckeeper uses):
http://david.hardeman.nu/software.php

Unfortunately neither git nor metastore can handle the high data
volumes that bup is aimed at (ie. your entire filesystem, including
huge files), which is why bup exists.  Give it a few weeks and we
should have some decent metadata handling in place though.

Have fun,

Avery
