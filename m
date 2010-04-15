From: Mark Rada <marada@uwaterloo.ca>
Subject: Re: [PATCH] gitweb: simplify gitweb.min.* generation and clean-up
 rules
Date: Thu, 15 Apr 2010 00:11:40 -0400
Message-ID: <4BC691FC.8040401@mailservices.uwaterloo.ca>
References: <4BC689FF.9080308@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Charles Bailey <charles@hashpling.org>
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Thu Apr 15 06:17:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2GWV-0002kB-Jh
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 06:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293Ab0DOERr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 00:17:47 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:33135 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753047Ab0DOERq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010 00:17:46 -0400
Received: from [192.168.26.20] (bas1-toronto01-1177646445.dsl.bell.ca [70.49.117.109])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o3F4BerO010710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 Apr 2010 00:11:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BC689FF.9080308@mailservices.uwaterloo.ca>
X-UUID: befe97b1-3768-428c-b84b-f19efdb2c58b
X-Miltered: at mailchk-m05 with ID 4BC691FC.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Thu, 15 Apr 2010 00:11:43 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144946>

On 10-04-14 11:37 PM, Mark Rada wrote:
> GITWEB_CSS and GITWEB_JS are meant to be "what URI should the installed
> cgi script use to refer to the stylesheet and JavaScript", never "this
> is the name of the file we are building".
> 
> Lose incorrect assignment to them.
> 
> While we are at it, lose FILES that is used only for "clean" target in a
> misguided way.  "make clean" should try to remove all the potential
> build artifacts regardless of a minor configuration change.  Instead of
> trying to remove only the build product "make clean" would have created
> if it were run without "clean", explicitly list the three potential build
> products for removal.
> 
> In addition, this patch tries to make sure that the scripts are
> regenerated whenever the replacement variables are modified.  For a good
> measure, if you used different JSMIN/CSSMIN since the last time you
> produced minified version of these files, they are regenerated.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Tested-by: Mark Rada <marada@uwaterloo.ca>
> 
> 
> ---
> 
> I gave this a test run:
> 	With just jsmin enabled
> 	With just cssmin enabled
> 	With neither enabled
> 	With both enabled
> 	Overriding GITWEB_JS
> 	Overriding GITWEB_JS and jsmin enabled

I should have mentioned that this these were done successively, without running
`make clean', and using the autoconfigure script to set JSMIN/CSSMIN.


-- 
Mark Rada
