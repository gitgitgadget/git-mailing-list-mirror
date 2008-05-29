From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: How to merge branches except for one commit
Date: Wed, 28 May 2008 22:42:16 -0400
Message-ID: <32541b130805281942g2550cad9k7ba530c59e050aa4@mail.gmail.com>
References: <216e54900805281932v1397fd30sad91f767175ba95e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andrew Arnott" <andrewarnott@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 04:43:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Y6x-000452-9u
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 04:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754868AbYE2CmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 22:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbYE2CmV
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 22:42:21 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:20061 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754189AbYE2CmT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 22:42:19 -0400
Received: by an-out-0708.google.com with SMTP id d40so22155and.103
        for <git@vger.kernel.org>; Wed, 28 May 2008 19:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qOHxyHVl7elK2LMCRLcx7O6Ri2wpt+qaVGxwwFLvqMg=;
        b=i3H63+TqLiaS0vDRTSyNNqZG5oUgbQaTTG/BxULK2xarvHEX2Rkpfd6qO8MDwpfrwquINCqGpIJTqmUI6qDwwAq+4ipqyrpMFQ6a0v1091lyMdkUQW12TSpZlpJxy/DYZuJh865lVVQxIyEZ/QbTHFHCCa1lPIupYl0kK88tB1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Br5Fe0QlhSMcCR7KtZ3dJn5hVfKQkaNf2UvlTfCghN59JkrA8nI7a5VfT9RL2TToBq3I/vylABzMR9pZ/WEnbDAYCC603eVjC90swdDf4HKDfpV4cZD2kJ2rvcuo5q90vI5uK8j+K6haXOZn+JLI11NomjDpFZtRMFl+rh36Cg4=
Received: by 10.100.229.12 with SMTP id b12mr5299115anh.60.1212028936561;
        Wed, 28 May 2008 19:42:16 -0700 (PDT)
Received: by 10.100.8.19 with HTTP; Wed, 28 May 2008 19:42:16 -0700 (PDT)
In-Reply-To: <216e54900805281932v1397fd30sad91f767175ba95e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83166>

On 5/28/08, Andrew Arnott <andrewarnott@gmail.com> wrote:
>  At some point, most or all the commits on master since branching off
>  v1.0 I want to include in the v1.1 release.

I think this is perhaps the root of your problem.  Normally people
don't merge from master into their bugfix release; they do it the
other way around, making bugfixes in the bugfix branch, and merging
them occasionally into master.

Or alternatively, they cherry pick just *some* of the changes from
master back into the bugfix release, because presumably there are also
a bunch of non-critical new feature patches sitting in master.

If you really want to do it the way you described, an easy answer
might be to just merge the entire master into v1.1, then "git revert"
(in v1.1) the patch that changes the version number :)

Have fun,

Avery
