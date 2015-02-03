From: Bryan Turner <bturner@atlassian.com>
Subject: Re: folder naming bug?
Date: Tue, 3 Feb 2015 15:37:19 +1100
Message-ID: <CAGyf7-FXhhW74DvcO8nbWud9A868AYqKj_zY61wmf9XGvH4eQA@mail.gmail.com>
References: <27503C0E-7D33-4893-AD25-6A821D31FAB1@sparkstart.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Kevin Coleman <kevin.coleman@sparkstart.io>
X-From: git-owner@vger.kernel.org Tue Feb 03 05:37:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIVEs-00027E-81
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 05:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932879AbbBCEhV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Feb 2015 23:37:21 -0500
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:57329 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752140AbbBCEhU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 Feb 2015 23:37:20 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]) (using TLSv1) by na3sys009aob105.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVNBQf2Ce2+63EWiKvrNlQ8vnQlUN1DXr@postini.com; Mon, 02 Feb 2015 20:37:20 PST
Received: by mail-oi0-f45.google.com with SMTP id g201so47445289oib.4
        for <git@vger.kernel.org>; Mon, 02 Feb 2015 20:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lY1Qbtf+jYAt3YPovIIZ8bDKwPBlWkyn9GYKtJoP+RM=;
        b=D1ItEoydjZw0qd3ixxDYP1dV5w+Fa/KwdDkvYtlvTIYTTnaG31b7YV7L4B1zWrxoil
         dLWV79CEB3rGIp+yvp6/UA+xG8AGPSEl7DFqXVxIHS1LCHaQ4R8PQqSZ2yDv2nKrG3jS
         DzuHAqzMCXRcFSSYEyzIR68Mv/Aows/VLKO1YiOtFRmTe98vbydZvzqCn1RjYr4OxoFo
         1kNGnNfaWY7VytuRwuPBTNPmKlbGpj1fllXaSGOibPI6HbXytVrNA1YwU6bod4SdYebD
         Rj+zMrgjhpMmBDESByudRgpqzY7vZCFnzVBmOYu/rlan/TxcIQaGBb5Sg8h6xHAY5nrc
         NEvA==
X-Gm-Message-State: ALoCoQkXghPt702E4cPM3B0h9nbVRoD/8o+qrsFpB+xV6qDBiMh8oQKdfkMNUAXwmbEoutkLnoIcx20mio2KHs1MQNsfQ9nQdSYLujLjFrPZhw5//CTTxuKIrGekPdTZC7ljuJvbuhPjQ013JhjudLoHAMhMJF30/A==
X-Received: by 10.202.44.216 with SMTP id s207mr13290322ois.106.1422938239250;
        Mon, 02 Feb 2015 20:37:19 -0800 (PST)
X-Received: by 10.202.44.216 with SMTP id s207mr13290316ois.106.1422938239095;
 Mon, 02 Feb 2015 20:37:19 -0800 (PST)
Received: by 10.182.98.225 with HTTP; Mon, 2 Feb 2015 20:37:19 -0800 (PST)
In-Reply-To: <27503C0E-7D33-4893-AD25-6A821D31FAB1@sparkstart.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263304>

Are you, by any chance, on MacOS? HFS+ by default is
case-insensitive-but-case-preserving, and Git on MacOS by default runs
with core.ignorecase =3D true as a result.

If you set that to false does it change the behavior?

Hope this helps,
Bryan Turner

On Tue, Feb 3, 2015 at 12:56 PM, Kevin Coleman
<kevin.coleman@sparkstart.io> wrote:
> git isn=E2=80=99t tracking folder renames when the case of the letter=
s change, but it will track it if the folder changes names.  Is this in=
tentional?
>
> Here is an example:
>
> 08:51:26 ~/test $ git init
> Initialized empty Git repository in /Users/kcoleman/test/.git/
> 08:51:29 ~/test (master #) $ mkdir main
> 08:51:44 ~/test (master #) $ cd main
> 08:51:46 ~/test/main (master #) $ touch readme.md
> 08:51:50 ~/test/main (master #) $ ls
> readme.md
> 08:51:53 ~/test/main (master #) $ cd ..
> 08:51:54 ~/test (master #) $ git add .
> 08:51:59 ~/test (master #) $ git commit -m "one"
> [master (root-commit) b0fddf6] one
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 main/readme.md
> 08:52:04 ~/test (master) $ cd main
> 08:52:14 ~/test/main (master) $ cd ..
> 08:52:27 ~/test (master) $ mv main Main
> 08:53:51 ~/test (master) $ git status
> On branch master
> nothing to commit, working directory clean
> 08:53:53 ~/test (master) $ ls
> Main
> 08:54:02 ~/test (master) $ mv Main MainA
> 08:55:44 ~/test (master *) $ git status
> On branch master
> Changes not staged for commit:
>   (use "git add/rm <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
>
>         deleted:    main/readme.md
>
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>
>         MainA/
>
> no changes added to commit (use "git add" and/or "git commit -a")
> 08:55:45 ~/test (master *) $--
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
