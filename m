From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH/RFC 0/3] gitweb: Split gitweb.js, improve JavaScript
Date: Fri, 25 Mar 2011 15:03:22 -0700
Message-ID: <4D8D112A.5020703@eaglescrag.net>
References: <1301089586-8534-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 23:03:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3F6X-0003n9-L1
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 23:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426Ab1CYWD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 18:03:29 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:42738 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab1CYWD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 18:03:27 -0400
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p2PM3NCp014877
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Fri, 25 Mar 2011 15:03:23 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <1301089586-8534-1-git-send-email-jnareb@gmail.com>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Fri, 25 Mar 2011 15:03:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170026>

The only thing I would comment on is that we may want to document (for
the build process) a way to force a certain ordering of various files.
Case in point we probably want to force the things like various global
defs (what I'm proposing in the timezone stuff) at the top and let the
function defs go below that.

Other than that this all looks good.

- John 'Warthog9' Hawley

On 03/25/2011 02:46 PM, Jakub Narebski wrote:
> This patch series is inspired by patch by John 'Warthog9' Hawley
> 
>   [PATCH 1/1] gitweb: javascript ability to adjust time based on timezone
>   Message-Id: <1300925335-3212-2-git-send-email-warthog9@eaglescrag.net>
>   http://thread.gmane.org/gmane.comp.version-control.git/169384/focus=169882
> 
> that added a few new JavaScript files for the new feature that this
> patch implemented.
> 
> This is marked as RFC mainly because other patches in series,
> especially the last one fixing bug in gitweb's JavaScript code, should
> be send independently on gitweb.js splitting.
> 
> Jakub Narebski (3):
>   gitweb: Split JavaScript for maintability; concatenate on build
>   gitweb: Update and improve comments in JavaScript files
>   gitweb: Fix parsing of negative fractional timezones in JavaScript
> 
>  .gitignore                                         |    1 +
>  gitweb/Makefile                                    |   12 +-
>  .../static/{gitweb.js => js/blame_incremental.js}  |  216 ++------------------
>  gitweb/static/js/common-lib.js                     |  191 +++++++++++++++++
>  gitweb/static/js/detect-javascript.js              |   44 ++++
>  5 files changed, 261 insertions(+), 203 deletions(-)
>  rename gitweb/static/{gitweb.js => js/blame_incremental.js} (75%)
>  create mode 100644 gitweb/static/js/common-lib.js
>  create mode 100644 gitweb/static/js/detect-javascript.js
> 
