From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: using gvim as editor on Windows
Date: Fri, 5 Mar 2010 23:22:34 -0800
Message-ID: <8c9a061003052322v446acddbm5792038af450d0b9@mail.gmail.com>
References: <20100306070628.GM2480@ece.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tait <git.git@t41t.com>
X-From: git-owner@vger.kernel.org Sat Mar 06 08:23:12 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnoLv-0001Vn-JB
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 08:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151Ab0CFHW4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Mar 2010 02:22:56 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50528 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074Ab0CFHWz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Mar 2010 02:22:55 -0500
Received: by pwj8 with SMTP id 8so2833824pwj.19
        for <git@vger.kernel.org>; Fri, 05 Mar 2010 23:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=n7jNEzFtEgcfR8vqauvNKAw6eEi3WkxRYVV7nKjiQ+A=;
        b=UQYdjUWmAVacvz2Ge9ZYtCJGTe1cfOq3tQQRnDNj74AxCcPuCsYI+16ieAA5gSrg79
         mo/k71titDkjt4Kk4YcWCxNVyCLzppvGyk1u5U6YbnWQh5hGTjVbRLjiEwDVstP6VZC3
         9a6mctBehZMsRcJi+oIpnm93DkwEKkEh6B5gM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=L38ZGUeiJ6MqYc3jcqmNa4Whck+uhaxJeSfesv2B58gZ+Ks/VWNWIvbe6ZjORMdZtV
         5JnsVCT5Z1PnVUsNaFdnaZaaJ2l+MeWUHHGIyFOKWZP+XEk/TfpAglgDYWRcHSYrKUBE
         ulgjmuNvE/X7foX6v7It/3lseLmyn0FIB47PU=
Received: by 10.141.105.16 with SMTP id h16mr1321839rvm.15.1267860174060; Fri, 
	05 Mar 2010 23:22:54 -0800 (PST)
In-Reply-To: <20100306070628.GM2480@ece.pdx.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141608>

On Fri, Mar 5, 2010 at 23:06, Tait <git.git@t41t.com> wrote:
>
> I'd prefer to use gvim as an editor on Windows XP instead of vim. (I =
also
> prefer it as a difftool, but that's a separate issue.) Gvim releases
> the terminal when it launches, which git doesn't like too much. So I
> create gvimf.cmd in my path and use it for core.editor. Gvimf.cmd is
> quite simple; it calls:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0start "dummy" /b /wait "C:\Program Files\V=
im\vim72\gvim.exe" %*
>
> In .gitconfig:
> [core]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0editor =3D gvimf.cmd
>
> This works well enough for git commit. However, git rebase -i is not
> happy. It errors:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0C:\path to\repo> git rebase -i HEAD~10
> =C2=A0 =C2=A0 =C2=A0 =C2=A0The system cannot find the file dummy.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Could not execute editor
>
> Okay, I can fix that. I change core.editor to "cmd \\/c gvimf.cmd". (=
This
> is the same pattern I use for gvim as a difftool.) Now my .gitconfig =
has:
> [core]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0editor =3D cmd \\\\/c gvimf.cmd
>
> Git rebase is happy, but git commit is not. It errors:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0C:\path to\repo> git commit
> =C2=A0 =C2=A0 =C2=A0 =C2=A0'OMMIT_EDITMSG' is not recognized as an in=
ternal or external command,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0operable program or batch file.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0error: There was a problem with the editor=
 'cmd \\/c gvimf.cmd'.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Please supply the message using either -m =
or -F option.
>
> In the selfish hope to avoid work, has anyone else already encountere=
d
> and solved how to use gvim as an editor?
>
> Tait
>

Use the -f (stay in the foreground) flag.  I haven't tried this in
Windows, but that's how I've used it in Linux.

[core]
    editor =3D gvim -f
