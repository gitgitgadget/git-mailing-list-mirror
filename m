From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] glossary: add "remote", "submodule", "superproject"
Date: Thu, 28 May 2015 09:45:41 -0700
Message-ID: <xmqqk2vsirbe.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kauSsZK3_X+zTwL8TKuZiHNMGvMZfoCemW9-K7RWgrgCA@mail.gmail.com>
	<1432777801-6073-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, philipoakley@iee.org, hvoigt@hvoigt.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 28 18:47:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy0xm-00067B-Jg
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 18:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbbE1QrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 12:47:17 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34787 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932258AbbE1Qpn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 12:45:43 -0400
Received: by igbhj9 with SMTP id hj9so119468564igb.1
        for <git@vger.kernel.org>; Thu, 28 May 2015 09:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=YXGdaKbYhosmv6KKzjj3vXHld6OS8gkbcMtYvSzLChU=;
        b=xdrMwBPwC2HRWlLa8dTUqwbfnW9KM+w3cWs3/55ipONgDCW9AtMEzF7aZGOZO9Wvz3
         z8PEVrslsGcLX7qcJ0NSfAXuhSrjmdjQdgSn79kVqEEyzj1vNPMwCEauYm7/CkH1RccV
         grhz/AjQ99CO6ocqNlu0Ptv3NAGK7ztAefi4d6YUxQbzZWj56bZDSQMqUOk6OznEB+Gg
         GLJArsJE6UT46r1A/NyQAhVTs1wXzmNz5nHicr248q8m7iQpmOleY2sbaV9owUKbRQdY
         4GSiFEmF6emsGb5KyJEJvoMqXZcfar3KCB3l9Q60WpYk9jLX5oL2I5xw9cppK7B4NrCZ
         R2Ug==
X-Received: by 10.50.41.8 with SMTP id b8mr44875047igl.38.1432831542925;
        Thu, 28 May 2015 09:45:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id b8sm2129833ioe.23.2015.05.28.09.45.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 May 2015 09:45:42 -0700 (PDT)
In-Reply-To: <1432777801-6073-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 27 May 2015 18:50:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270158>

Stefan Beller <sbeller@google.com> writes:

> Noticed-by: Philip Oakley <philipoakley@iee.org>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/glossary-content.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

The updates in this version relative to the previous one looks very
good, at least to me.  A bit more comments.

> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index bf383c2..23ab692 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -469,6 +469,11 @@ The most notable example is `HEAD`.
>  	<<def_push,push>> to describe the mapping between remote
>  	<<def_ref,ref>> and local ref.
>  
> +[[def_remote]]remote repository::
> +	A <<def_repository,repository>> which is used to track the same
> +	project but resides somewhere else. To communicate with remotes,
> +	see <<def_fetch,fetch>> or <<def_push,push>>.
> +

The last sentence sounds a tiny bit strange, in that I have to do a
bit more than just see the explanation of these commands in order to
communicate with remotes.

But it probably is just me.

> @@ -515,6 +520,18 @@ The most notable example is `HEAD`.
>  	is created by giving the `--depth` option to linkgit:git-clone[1], and
>  	its history can be later deepened with linkgit:git-fetch[1].
>  
> +[[def_submodule]]submodule::
> +	A <<def_repository,repository>> that holds the history of a
> +	separate project inside another repository (the latter of
> +	which is called <<def_superproject, superproject>>). The
> +	containing superproject knows about the names of (but does
> +	not hold copies of) commit objects of the contained submodules.

I agree with one point you mentioned in one of your messages, which
is that a submodule is not aware that it is used as part of a larger
project.  That makes me wonder if the last sentence sits better in
the description of the superproject, rather than the description of
the submodule.

> +[[def_superproject]]superproject::
> +	A <<def_repository,repository>> that references other repositories
> +	inside itself as <<def_submodule,submodules>>.

Perhaps "repositories of other projects"?  Does "inside" make it
clear enough that we are talking about the relationship between
working trees of the superproject and submodules?

> +	The superproject
> +	tracks only the remote and the name of the submodule.

I am not sure what this sentence means [*1*], and I do not know if
(a corrected version of) such a description is necessary here.

Thanks.

[Footnote]

*1* The superproject records a bit more than "remote and name" in
.gitmodules, and of course it records the history of the paths that
the submodule is bound to over time, with specific commits from the
submodule in its history.
