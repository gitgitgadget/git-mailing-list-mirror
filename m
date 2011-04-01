From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: Document diff.<tool>.* and filter.<driver>.* in config
Date: Fri, 01 Apr 2011 02:18:28 -0700 (PDT)
Message-ID: <m3ipuy49fg.fsf@localhost.localdomain>
References: <1301647658-28047-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 11:18:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5aV2-0006Gk-Ts
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 11:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182Ab1DAJSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 05:18:32 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49330 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803Ab1DAJSb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 05:18:31 -0400
Received: by wwa36 with SMTP id 36so3838109wwa.1
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 02:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=hvm07Zs8u48oEWYOBVrt5SY1Uy3HEaZbfSF4uXwgp3g=;
        b=NHnviTbdzZ9S+89Tq3Bm3DEmREuWLsvCQEsRfRXP2HPaE+W9h6m+VSbootKa8j5dMS
         5G+0qQAbNulcj2XJIJDMUwkkGHPXfe22vcPT+F36/pd0DtCXpoVizw4/hYhYz1gIy113
         VOEUe9sif9hrFq6cl4w9icWWIgl+aMMLLUxN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=iiejx24LOTpd0KGrx7ZG9IMz43H1A0fvBJOlN/NcdU5g/Wd3IyBfVwi7zBQCqV2C61
         6cFjnAoJtuiP6xFKTZC2/k+FuEiUa5L1HYjR8Dddwhewmp3TvcN+3XAHpJtJ96znF/cU
         X7A3BWm6WgGdGgD3mnSuzbn/bXExW8Cvg4baY=
Received: by 10.216.120.129 with SMTP id p1mr3826521weh.81.1301649510119;
        Fri, 01 Apr 2011 02:18:30 -0700 (PDT)
Received: from localhost.localdomain (abvl248.neoplus.adsl.tpnet.pl [83.8.209.248])
        by mx.google.com with ESMTPS id r57sm893809wes.25.2011.04.01.02.18.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Apr 2011 02:18:28 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p319I1PY004705;
	Fri, 1 Apr 2011 11:18:16 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p319HuqL004702;
	Fri, 1 Apr 2011 11:17:56 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1301647658-28047-1-git-send-email-artagnon@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170564>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Although the gitattributes page contains comprehensive information
> about these configuration options, they should be included in the
> config documentation for completeness.

Good idea.

> +diff.<tool>.command::
> +	Defines a human-readable name for a custom low-level diff
> +	tool.  See linkgit:gitattributes[5] for details.
> +
> +diff.<tool>.xfuncname::
> +	Defines the command that implements a custom low-level merge
> +	tool.  See linkgit:gitattributes[5] for details.
> +
> +diff.<tool>.textconv::
> +	Names a low-level merge tool to be used when performing an
> +	internal merge between common ancestors.  See
> +	linkgit:gitattributes[5] for details.
> +
> +diff.<tool>.cachetextconv::
> +	Names a low-level merge tool to be used when performing an
> +	internal merge between common ancestors.  See
> +	linkgit:gitattributes[5] for details.
> +

WTF?!?  You have seriously messed up matching description to config
variables.

The human readable-name for a custom diff tool or file-level (contents)
merge driver is the '<tool>' part of e.g. `diff.<tool>.command`, not the
value of said config variable.

It should IMVHO be something like this:

  +diff.<tool>.command::
  +	Defines command to be called to generate diff for files
  +	with `diff=<tool>` gitattribute.  See linkgit:gitattributes[5]
  +	for details.
  +
  +diff.<tool>.xfuncname::
  +	Specifies a regular expression that matches a line that you
  +	would want to appear as hunk header for files with `diff=<tool>`
  +	gitattribute, similarly to `--show-function-line=REGEXP` option
  +	of GNU diff.  See linkgit:gitattributes[5] for details.
  +
  +diff.<tool>.textconv::
  +	Defines command to be called to generate text-converted version
  +	of a binary file with `diff=<tool>` gitattribute.  The result of
  +	the conversion is used to generate human-readable diff.  See
  +	linkgit:gitattributes[5] for details.
  +
  +diff.<tool>.cachetextconv::
  +	Set to true to enable caching of text conversion.  See
  +	linkgit:gitattributes[5] for details.

There is also `diff.<tool>.wordRegex` to be described.  And probably some
more (I didn't check which of gitattribute-related config variables are
already described).

> +filter.<driver>.clean::
> +	Defines the command to be used to convert the contents of
> +	worktree file upon checkin.  See linkgit:gitattributes[5] for
> +	details.
> +
> +filter.<driver>.smudge::
> +	Defines the command to be used to convert the blob object to
> +	worktree file upon checkout.  See linkgit:gitattributes[5] for
> +	details.

This one is correct.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
