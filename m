From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] glossary: add "remote" and "submodule"
Date: Wed, 27 May 2015 15:29:42 -0700
Message-ID: <xmqq617dk621.fsf@gitster.dls.corp.google.com>
References: <1432761209-4120-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: philipoakley@iee.org, git@vger.kernel.org, hvoigt@hvoigt.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 28 00:29:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxjpk-0003a1-Vd
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 00:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbbE0W3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 18:29:46 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34116 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932314AbbE0W3o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 18:29:44 -0400
Received: by ieczm2 with SMTP id zm2so25109899iec.1
        for <git@vger.kernel.org>; Wed, 27 May 2015 15:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=QK/naFeZHWXPIBmJefEhBbvu/KHZcDeXoW2BrkkkjKM=;
        b=agXPvOIWi+3AT6q8+TBu91ZO/EvV0qAQSbL7ohQkKXt7tk4NxPCCz6OHRyLI7hu7TE
         w3XTphsfWOGIVXo1YlR34DaMz2/Sw59xl1sxFAuZHRzYkmpKXDUPQTEg8uUXi/vxr5n4
         WStUWvW87HKFPXirMJeGfMosxBmJxapn/LaQdiCU7dbQ+LQaO5Xyjwns3YFpFdLn8XxS
         0eMsPzA0cTfKD4q2dff7gEsAFWBJG04hXM5n3BEwkwvsqK7Z572VcUU+uWvWqpM/gebx
         A39Qfo1BKbjec5I801+EIe7rrpUHyAT69o8DaQphDQUnAfze1Ik7Ri1EtrXRe1kL4G0d
         1ieQ==
X-Received: by 10.50.12.102 with SMTP id x6mr7462464igb.20.1432765783905;
        Wed, 27 May 2015 15:29:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id i4sm11831101igm.2.2015.05.27.15.29.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 15:29:43 -0700 (PDT)
In-Reply-To: <1432761209-4120-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 27 May 2015 14:13:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270114>

Stefan Beller <sbeller@google.com> writes:

> Noticed-by: Philip Oakley <philipoakley@iee.org>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/glossary-content.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index bf383c2..e303135 100644
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

OK.

> @@ -515,6 +520,11 @@ The most notable example is `HEAD`.
>  	is created by giving the `--depth` option to linkgit:git-clone[1], and
>  	its history can be later deepened with linkgit:git-fetch[1].
>  
> +[[def_submodule]]submodule::
> +	A <<def_repository,repository>> inside another repository. The two
> +	repositories have different history, though the outer repository
> +	knows the commit of the inner repository.

I'd stress that they are not just different histories (as the
'master' and the 'maint' branches of my project has different
histories) but they are separate projects.  Perhaps like this?

       A repository that holds the history of a separate project
       inside another repository (the latter of which is called
       superproject).  The containing superproject knows about the
       names of (but does not hold copies of) commit objects of the
       contained submodules.

It is not like that it is strange or unintuitive that the
superproject knows about some commits in its submodule.  "X, though
Y" however makes it sound as if Y is true "despite X".  I do not
think there is any "despite" here.
