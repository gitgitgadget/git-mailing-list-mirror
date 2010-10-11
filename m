From: Pat Notz <patnotz@gmail.com>
Subject: Re: [PATCHv5 0/8] Add commit message options for rebase --autosquash
Date: Mon, 11 Oct 2010 15:06:38 -0600
Message-ID: <AANLkTikZJWpm054Aw51Yt2CruEtx1XfX38vsVD8wVcOX@mail.gmail.com>
References: <1286478657-61581-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 11 23:07:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5PaO-0003Vz-N3
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 23:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756306Ab0JKVHA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 17:07:00 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38989 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756340Ab0JKVHA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Oct 2010 17:07:00 -0400
Received: by fxm4 with SMTP id 4so690262fxm.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 14:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=qI6gu8UqdsDMX2PT8wPZ0MTWAPXS3xomA9ku5SEcBlM=;
        b=r0sndt4goAArWI7el43MKnz/Ni0wtYxvsrufXPhqqR6sP7c8J7+jRhmlYRAVFlu3c7
         Df6efyGk3QggHBOHxbc6TQIda8nxIb7t/EuOWIPcjdk+uxuNoWXj5gOiMqF2Yo1IAF66
         YFfTJ9oiMHk7rrWdtLnv6YpXB/4uLsrEnCazs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=wu8lWnBDyknrmNywuAnogC58zXGwy4mcZWr/X6ouIHXulhn+wxuENKC6PBIeKffQ8k
         ycgzYuP3tkOkYq+486YfBTRWx09hRCNSEIFDpqMsxUvvziCT/THqd4Pm6EcPaDbVyIya
         D7/f2u3wE3aB413EkxWcpRYNNHeVRf5iTnY3c=
Received: by 10.239.193.134 with SMTP id j6mr403258hbi.65.1286831218661; Mon,
 11 Oct 2010 14:06:58 -0700 (PDT)
Received: by 10.239.185.65 with HTTP; Mon, 11 Oct 2010 14:06:38 -0700 (PDT)
In-Reply-To: <1286478657-61581-1-git-send-email-patnotz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158790>

Hiya -

I didn't receive any feedback from this patch series so I thought I'd
just ping the list to see if this is of interest at all (I fully
accept that it might not be). Or perhaps no news is good news. Anyway,
sorry for the spam.

~ pat

On Thu, Oct 7, 2010 at 1:10 PM, Pat Notz <patnotz@gmail.com> wrote:
> This patch series adds new command line options to git-commit to make
> it easy to specify messages for commits correctly formatted for use
> wit 'rebase -i --autosquash'.
>
> The first three patches introduce minor refactorings that set the sta=
ge
> for subsequent patches.
>
> The fourth patch teaches format_commit_message to reencode the conten=
t
> if the caller's commit object uses an encoding different from the
> commit encoding.
>
> The remaining patches add the --fixup and --squash commands to
> git-commit including tests of commit, interactions with rebase and
> i18n encodings.
>
> One issue which limits the testing (but not the implementation, I
> think) is that when 'rebase --autosquash' is comparing commit subject
> lines it does not first make sure that the commits use a common
> encoding. =A0That's follow-on work.
>
> Pat Notz (8):
> =A0commit.c: prefer get_header() to manual searching
> =A0commit.c: new function for looking up a comit by name
> =A0pretty.c: helper methods for getting output encodings
> =A0pretty.c: teach format_commit_message() to reencode the output
> =A0commit: --fixup option for use with rebase --autosquash
> =A0add tests of commit --fixup
> =A0commit: --squash option for use with rebase --autosquash
> =A0add tests of commit --squash
>
> =A0Documentation/git-commit.txt | =A0 21 +++++++++--
> =A0archive.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0builtin/commit.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 76 ++++++++++++++++=
+++++++++++------------
> =A0builtin/fmt-merge-msg.c =A0 =A0 =A0| =A0 =A02 +-
> =A0cache.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03 ++
> =A0commit.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 13 +++++++
> =A0commit.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A05 ++-
> =A0environment.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 ++++++
> =A0log-tree.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0notes-cache.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0pretty.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 47 ++++++++=
+++++++++++-----
> =A0submodule.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 +-
> =A0t/t3415-rebase-autosquash.sh | =A0 29 ++++++++++++++-
> =A0t/t3900-i18n-commit.sh =A0 =A0 =A0 | =A0 28 +++++++++++++++
> =A0t/t7500-commit.sh =A0 =A0 =A0 =A0 =A0 =A0| =A0 80 ++++++++++++++++=
++++++++++++++++++++++++++
> =A0t/t7500/edit-content =A0 =A0 =A0 =A0 | =A0 =A04 ++
> =A016 files changed, 283 insertions(+), 46 deletions(-)
> =A0create mode 100755 t/t7500/edit-content
>
> --
> 1.7.3.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
