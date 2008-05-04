From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCHv4 0/4] Show author and/or committer in some cases
Date: Sun, 4 May 2008 18:25:40 +0200
Message-ID: <8aa486160805040925i6a10d704oa31651cc2b244322@mail.gmail.com>
References: <1209917092-12146-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 18:26:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsh2j-0004yY-Fs
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 18:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717AbYEDQZm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2008 12:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753506AbYEDQZm
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 12:25:42 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:34522 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532AbYEDQZl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 May 2008 12:25:41 -0400
Received: by yw-out-2324.google.com with SMTP id 9so286601ywe.1
        for <git@vger.kernel.org>; Sun, 04 May 2008 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GeAGnsxEcXHSVQ80cFnPANlELnahZQ3fB3tDRoqVq1c=;
        b=XZXosMh1UYNMfW2WzcDwftMOUeDMB7FL70Q+tmlRrMCLeDc6V7ej8NddXvxyZlcG6kC0z1uwPKSTCr7WnC+Taga0D4YnZuDkVK0gh02bw+xVAFlxbX2tx+zUGmdkCgkBA1q322REq7qZvCyBX9Z9idwx5CtwiqEXc6scfQSnQm0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=u3WTcJodD5bXVF+NoZA9bdTiqJf5FltUq1ejUcyWlC2F2vu2/TsP6AxFk+VwMeXbPWmTtL5NtMOcNNbQUrtImRiC2i4qRsyyOvsbxLbDCqZpgSQOb0Rc64/WC+sL9hXyWxoow1gM0ek59FWzDnVQpKFLl2uRQv5HzgYhAm9qxRU=
Received: by 10.150.228.2 with SMTP id a2mr5271252ybh.245.1209918340360;
        Sun, 04 May 2008 09:25:40 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Sun, 4 May 2008 09:25:40 -0700 (PDT)
In-Reply-To: <1209917092-12146-1-git-send-email-sbejar@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81183>

On Sun, May 4, 2008 at 6:04 PM, Santi B=E9jar <sbejar@gmail.com> wrote:
> Hi *,
>
>   This patch series tries to make more evident the author and committ=
er ident
>  in case the user might be using an unintended author/committer ident=
ity.
>

Oops, I send it without saving the buffer.

Changes since last round (v3?):

	* removed an unused function
 	* Add comment why git_committer_info is called discarding the value
	* Minor changes to the tests

>  Santi
>
>  Santi B=E9jar (4):
>   Preparation to call determine_author_info from prepare_to_commit
>   commit: Show author if different from committer
>   commit: Show committer if automatic
>   user.warnautomatic: add config to control if the committer ident is
>     shown
>
>   Documentation/config.txt |    4 ++
>   builtin-commit.c         |  112 +++++++++++++++++++++++++++++------=
----------
>   cache.h                  |    2 +
>   config.c                 |    9 ++++
>   environment.c            |    2 +
>   ident.c                  |    3 +
>   t/t7502-commit.sh        |   38 ++++++++++++++++
>   7 files changed, 130 insertions(+), 40 deletions(-)
>
>
