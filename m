From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 2/5] command-list.txt: add the common groups block
Date: Wed, 20 May 2015 15:48:45 -0400
Message-ID: <CAPig+cTM4L7Vt1gYb5zvAgt8hsqGQdLWigN_yB-VsWukNbt=zw@mail.gmail.com>
References: <1432149781-24596-1-git-send-email-sebastien.guimmara@gmail.com>
	<1432149781-24596-3-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 21:48:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv9z0-0008F9-Uv
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 21:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732AbbETTsr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2015 15:48:47 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35508 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbbETTsq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 May 2015 15:48:46 -0400
Received: by igbyr2 with SMTP id yr2so111770674igb.0
        for <git@vger.kernel.org>; Wed, 20 May 2015 12:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=MFmrMKglR3i7vDVOumB059I3XmitQ4Jp8TNIpsW0968=;
        b=0aFohP97yxKirQtyzUOnH1qJCOTdVZStGTBGEaUw9je7oQHiXzTsaXJIGUaW9NMexg
         GkK2ITWwM1dSpA4Soad8jS4rYffnbloKeDqrdBAo1+Mknvz0hL/RH/1vb3aKgDt8fujE
         0ODMyUtockk+Wr1NjpewynxOr0IibcY+e+C0g+rZod/mnXgSMdP+9mzbsAF8kemeTc/W
         MsD25Sd8hQuB6dk+n2NHD+QCi7C6CNu9NiUlTJw6HED+zqhZVT/XcWq5uHT7FIcBV8Uv
         EHJvr7uy/xF5r7CB4gbB1cHBa9kzOmR7IZrILJNIRi/yZQt6ufzshch2ZPGqhwrR5Q+g
         A2ug==
X-Received: by 10.42.67.80 with SMTP id s16mr33456677ici.25.1432151325922;
 Wed, 20 May 2015 12:48:45 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Wed, 20 May 2015 12:48:45 -0700 (PDT)
In-Reply-To: <1432149781-24596-3-git-send-email-sebastien.guimmara@gmail.com>
X-Google-Sender-Auth: oNPK_la402OXEM1Aa7_MroYi7yc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269509>

On Wed, May 20, 2015 at 3:22 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> The ultimate goal is for "git help" to display common commands in
> groups rather than alphabetically. As a first step, define the
> groups in a new block, and then assign a group to each
> common command.
>
> Add a block at the beginning of command-list.txt:
>
>     init         start a working area (see also: git help tutorial)
>     worktree     work on the current change (see also:[...]
>     info         examine the history and state (see also: git [...]
>     history      grow, mark and tweak your history
>     remote       collaborate (see also: git help workflows)
>
> storing information about common commands group, then map each common
> command to a group:
>
>     git-add          mainporcelain        common worktree
>
> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
> ---
>  command-list.txt | 50 ++++++++++++++++++++++++++++++----------------=
----
>  1 file changed, 30 insertions(+), 20 deletions(-)

Hmm, did your update to Documentation/technical/new-command.txt get
lost? I don't see it any of the patches, but would have expected it to
be included in this patch which introduces the "common groups"
section.

> diff --git a/command-list.txt b/command-list.txt
> index 609b344..c2bbdc1 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -1,3 +1,13 @@
> +# common commands are grouped by themes output by 'git help'
> +# map each common command in the command list to one of these groups=
=2E

Discussed previously: It also would be a good idea to mention that the
order in which "git help" displays the groups themselves is the order
they are declared here. Maybe just add one more line between the two
you already have above:

    # groups are output by 'git help' in the order declared here.

> +### common groups

In the block below, the "### command list" line is protected by a "#
do not molest the next line" warning. Perhaps the same should be done
here? Alternately, make them more compact by incorporating the
warning:

    ### common groups (do not change this line)
    ...
    ### command list (do not change this line)

?

> +init         start a working area (see also: git help tutorial)
> +worktree     work on the current change (see also: git help everyday=
)
> +info         examine the history and state (see also: git help revis=
ions)
> +history      grow, mark and tweak your common history
> +remote       collaborate (see also: git help workflows)
> +
> +# List of known git commands.
>  # do not molest the next line
>  ### command list
>  # command name                          category [deprecated] [commo=
n]
