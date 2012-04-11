From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Why can't git open empty branches ?
Date: Wed, 11 Apr 2012 05:59:06 -0500
Message-ID: <20120411105906.GA19823@burratino>
References: <4F855E6B.4010504@danisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Hadmut Danisch <hadmut@danisch.de>
X-From: git-owner@vger.kernel.org Wed Apr 11 12:59:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHvH3-0005On-65
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 12:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756096Ab2DKK7R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 06:59:17 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46767 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab2DKK7R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 06:59:17 -0400
Received: by iagz16 with SMTP id z16so1121067iag.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 03:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=obB/MjOSFd8eHRyUDkVanSRL6oISy1eoRTjEg7WtvVE=;
        b=UIuvAD4gy1EgMPDqGyaC7bgVIyoeKUUhY+AHftB4UqRmuSkzPQAq5yfdb6onv5gs2F
         RKj5vtVl13CUnu/l3rLadllfVFGMUg3HvvTb1o788wj67W0NLuLd1X226r/PqWjgyhog
         86jX0GGGT7s9WrvoGyo2tsMHt6TKgpCFx6PzOc2kSxNhBvgDDsSRwWlK2fVsGlhLlC3m
         JixCL208d5O4I8SFurc7WsAQj4C1fu/Pw9h3xcu7owOegRiwDQKUIvZitSlitE/Ezp7f
         h6dEyDVnx/Hl3tZGqBpGTS9jAOYq47JA4RziRco6TgvsSjNseVW0J/GNt2qkK4hnArx8
         ZFlw==
Received: by 10.43.51.10 with SMTP id vg10mr9059560icb.11.1334141956586;
        Wed, 11 Apr 2012 03:59:16 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gs4sm6785779igc.8.2012.04.11.03.59.15
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 03:59:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F855E6B.4010504@danisch.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195163>

Hadmut Danisch wrote:

> when creating a new branch in git, it is by default filled with the
> contents of the current branch.
>
> Sometimes a new but empty branch is needed. There are plenty of
> instructions in the web to achieve this with =E2=80=9Edirty tricks=E2=
=80=9D, i.e. fiddle
> around with git's internals.

	git init ../unrelated-topic
	cd ../unrelated-topic
	hack away...
	git commit
	cd -
	git fetch ../unrelated-topic master:<new branch>

Or:

	git checkout --orphan <new branch>
	git rm -fr .
	hack away...

Please feel free to contact the authors of the instructions you found
on the web to fix them.

Thanks and hope that helps,
Jonathan
