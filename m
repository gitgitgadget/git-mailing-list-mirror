From: Junio C Hamano <gitster@pobox.com>
Subject: Re: recovering from "unordered stage entries in index" error
Date: Sat, 23 May 2015 10:06:17 -0700
Message-ID: <xmqqsiancjg6.fsf@gitster.dls.corp.google.com>
References: <D377A9280DB18546A2471214D5CBB0E908599428C7@exchdb01>
	<CAPc5daVFA-FKTSUCRmb=JUr=H9ECtK8nJB3nyxHprCcJ+0CHBQ@mail.gmail.com>
	<D377A9280DB18546A2471214D5CBB0E9087568F50D@exchdb01>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "McHenry\, Matt" <mmchenry@carnegielearning.com>
X-From: git-owner@vger.kernel.org Sat May 23 19:06:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwCsT-0005Kl-Ew
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 19:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758049AbbEWRGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 13:06:20 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35497 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758003AbbEWRGT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 13:06:19 -0400
Received: by iesa3 with SMTP id a3so50434601ies.2
        for <git@vger.kernel.org>; Sat, 23 May 2015 10:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=inUBxA4k5vlpJUhuHZMX3Px3QSH00a26Melxm+yWUcA=;
        b=oqitYEY6krUfV7E0d7tE1x3EuD+ByVFr0fyW1WjVlYB+jAmC22DgcRb/DCzMAt59a8
         Y5jxQkq73ScMnndkvezYVJ+ewCgG4nHFGW2Jq//92MFaxaABRBJsSU3Vc3WxJzXxIajf
         EMtGPP4HH2k9evv5v/pP1kKAbIpSqyKxEMT97GX9O3PCQpzagtPs6h7fJ3I6FenHiyBJ
         r2/CYD3nBA0jVYooIdvkwLDB/5O0aqR5KbECl8SeL6KVBBfX8O1LMTBMh/1UQp3rhY7n
         KPk5dyiUqZUZzUIm/N/MfB3A6lg5+BObn/CJ/qi8BjJaHMruoQ8u9jVC3Ct0CSuVhhTt
         oAIg==
X-Received: by 10.50.73.169 with SMTP id m9mr11153291igv.37.1432400779066;
        Sat, 23 May 2015 10:06:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:609e:6a22:2d9d:c8d5])
        by mx.google.com with ESMTPSA id x10sm1917299igl.0.2015.05.23.10.06.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 23 May 2015 10:06:18 -0700 (PDT)
In-Reply-To: <D377A9280DB18546A2471214D5CBB0E9087568F50D@exchdb01> (Matt
	McHenry's message of "Fri, 22 May 2015 15:57:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269809>

"McHenry, Matt" <mmchenry@carnegielearning.com> writes:

> 	Yes, that does turn up some interesting stuff.  It looks
> 	like the repository contains some paths with non-ASCII
> 	characters, for example this one has some en-dashes (U+2013)
> 	in its name:

Then the recipe in the message you are responding to shoulld be
changed somewhat to tell Git that it is OK to show non-ASCII in
verbatim.

Perhaps doing this once

    git config core.quotepath false

before asking ls-files to show the paths should be sufficient.

Thanks.
