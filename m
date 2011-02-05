From: redstun <redstun@gmail.com>
Subject: Re: [idea] separate .git dir and the working tree
Date: Sat, 5 Feb 2011 22:24:25 +0800
Message-ID: <AANLkTinYMuXSvKjgtpSCbJPuo=PHDGR_OgOkwtV4Azmz@mail.gmail.com>
References: <AANLkTik4MjnpOzPdGy7ZDiH0in4e1DpjrhQFOHjUiEEE@mail.gmail.com>
 <20110205032339.GA15303@mg1> <20110205132708.GA18391@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Mike Gant <mike@gantsfort.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 15:26:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Plj5j-00046l-8V
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 15:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566Ab1BEOZI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Feb 2011 09:25:08 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45341 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab1BEOZH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Feb 2011 09:25:07 -0500
Received: by fxm20 with SMTP id 20so3394864fxm.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 06:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=hsOfX0IJwjvhRUzg8t/BHqQA1bOLbiRzVSRSTpQUpr0=;
        b=CTXs8p9icd/jfMDyBJThDIXcPWoy6fSvrQ4aQRwBPJueLB+S/m95tR4gtQLt0UhqYB
         MQjsmmjjjI7vXfvu8pKCA40Feg1VE4hd4vyGiwBFiIu2NOnRpNSpFuYBh1YMT1OnjnH3
         L8kemZYGQ6dkVM3+jnQNcFa+dK0WJpZyyrjZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=UDwo221citY4d9ASPe4GUWUsONSoPJwtA6+ELqtuX+dCQ1EgCMbqoi0sjNeTWlhW1o
         LV8S9n2pyAFR7BTU+183wlpQ59EznnryxYbKPd8b46muk82RAwz8zz3E5pQwjsSW9oNX
         Kkc4AYFAzHmtk0PdoEORVXDTL/rX5qmQwtVvo=
Received: by 10.103.220.8 with SMTP id x8mr8764229muq.92.1296915905715; Sat,
 05 Feb 2011 06:25:05 -0800 (PST)
Received: by 10.103.212.19 with HTTP; Sat, 5 Feb 2011 06:24:25 -0800 (PST)
In-Reply-To: <20110205132708.GA18391@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166095>

Making .git a symbol link is nice.

Regarding the GIT_DIR variable, looks like it needs to be paired with
the GIT_WORK_TREE variable, does this mean that I can only have one
local git repository?

what I wanted is, I may have multiple git working tree in my $HOME, lik=
e:
$HOME/proj1
$HOME/proj2,

I then wanted their .git directories respectively located at
/safe/disk/.git_proj1
/safe/disk/.git_proj2

How can I get this? I tried to read the doc but didn't have much luck.

Thanks

On Sat, Feb 5, 2011 at 9:27 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> (restoring cc list; please do not cull cc's)
>
> Mike Gant wrote:
>> On Sat, Feb 05, 2011 at 10:53:58AM +0800, redstun wrote:
>
>>> I think separating the .git directory from its working tree could
>>> increase the safety of the data to one more level higher.
> [...]
>> GIT_DIR and GIT_WORK_TREE might be what you are looking for. Explana=
tion
>> of usage in 'man git'
>
> The .git directory is allowed to be a symlink. =C2=A0Or a file like s=
o
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0gitdir: /path/to/git/repo
>
> for symlink-challenged operating systems. =C2=A0See gitrepository-lay=
out(7)
> for details.
>
> Cheers,
> Jonathan
>
