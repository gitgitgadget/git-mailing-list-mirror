From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] parse-options: introduce parse_subcommands
Date: Tue, 5 Jun 2012 18:32:57 -0500
Message-ID: <20120605233257.GG3619@burratino>
References: <1338802534-32394-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 01:33:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sc3FM-0004ed-99
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 01:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585Ab2FEXdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 19:33:03 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57512 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315Ab2FEXdC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 19:33:02 -0400
Received: by yhmm54 with SMTP id m54so4410030yhm.19
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 16:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AdMQfutedzYKEAJdJcs7WLinCakcj6Gm8HIs1WnKOSQ=;
        b=TYHAbwkl127rnlxg64HFqqxYdT1s45+OxoYGDedhy8NquxyAS9yDNx8ClzZWixNHhK
         6d8kiD3ckZnNNQTQgu/OnYG2uzEhlTnYaPCxY6LQ6KW71leu9bJarK1SgyYtRj4luJUO
         zKnHmyW07t8FPA3UmsVCQ6jGfdTVC8GJVmCjgEnhbOU1F+kxpR6rfmSwhwr2O3tM2v4N
         is4J5fY2DAv4uXdl5yiP4eFqWoX2HnXDEIeBoJGzwZYHcrOPMqeYTgIaXxtc6cDp49PL
         yDFDM32aGh+YAWcWfmH4zmoD61ll7ys7eYcsqcay4JzIOhwfKeJWRNPqun+uUl7ZXioM
         TUHg==
Received: by 10.42.158.201 with SMTP id i9mr6768585icx.4.1338939181271;
        Tue, 05 Jun 2012 16:33:01 -0700 (PDT)
Received: from burratino (adsl-99-31-159-111.dsl.chcgil.sbcglobal.net. [99.31.159.111])
        by mx.google.com with ESMTPS id z8sm310673igi.5.2012.06.05.16.33.00
        (version=SSLv3 cipher=OTHER);
        Tue, 05 Jun 2012 16:33:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1338802534-32394-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199298>

Hi,

Ramkumar Ramachandra wrote:

>   $ git notes foo
>   error: Unknown subcommand: foo
>   usage: git notes [--ref <notes_ref>] [list [<object>]]
>      or: git notes [--ref <notes_ref>] add [-f] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]
>      or: git notes [--ref <notes_ref>] copy [-f] <from-object> <to-object>
[...]
> is replaced by a more helpful:
>
>   $ git notes foo
>   error: unknown subcommand: foo
>   usage: git notes [<options>] [<subcommand>] [<options>] [<object>..]
>
>   available subcommands:
>       list                  list notes for given object
>       add                   add notes for given object
>       copy                  copy notes for first object onto second object
>       append                append notes to existing object
>       edit                  edit notes for given object
>       show                  show notes for given object
>       merge                 merge given notes ref into current notes ref
>       remove                remove notes for given objects
>       prune                 remove all notes for non-existing/unreachable objects
>       get-ref               print the current notes ref

The goal looks good.  As Junio said, the code looks simplifiable.

Hope that helps,
Jonathan
