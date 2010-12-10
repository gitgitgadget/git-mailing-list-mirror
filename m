From: Olaf Alders <olaf@wundersolutions.com>
Subject: Re: [RFC] Implementing gitweb output caching - issues to solve
Date: Thu, 9 Dec 2010 22:17:51 -0500
Message-ID: <88CF82F1-0363-47B4-8C6F-AE4A2DA1714B@wundersolutions.com>
References: <201011041721.53371.jnareb@gmail.com> <4D00316F.9000305@eaglescrag.net> <201012092330.06688.jnareb@gmail.com> <20101209225211.GA20426@burratino>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	"J.H." <warthog9@eaglescrag.net>, git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 04:25:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQtbc-0004qe-E5
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 04:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043Ab0LJDYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 22:24:35 -0500
Received: from mail.urwebhost.com ([64.37.82.104]:59270 "HELO
	mail.urwebhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753864Ab0LJDYe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Dec 2010 22:24:34 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2010 22:24:34 EST
Received: (qmail 10195 invoked by uid 523); 10 Dec 2010 03:17:52 -0000
Received: from localhost (HELO ?10.0.1.2?) (127.0.0.1)
  by mail.wundersolutions.com with SMTP; 10 Dec 2010 03:17:52 -0000
In-Reply-To: <20101209225211.GA20426@burratino>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163384>


On 2010-12-09, at 5:52 PM, Jonathan Nieder wrote:

> Jakub Narebski wrote:
> 
>> In my rewrite
>> 
>>  [PATCHv6 17/24] gitweb: Show appropriate "Generating..." page when regenerating cache
>>  http://thread.gmane.org/gmane.comp.version-control.git/163052/focus=163040
>>  http://repo.or.cz/w/git/jnareb-git.git/commitdiff/48679f7985ccda16dc54fda97790841bab4a0ba2#patch1
>> 
>> (see the browser_is_robot() subroutine:
>> 
>>  http://repo.or.cz/w/git/jnareb-git.git/blob/48679f7985ccda16dc54fda97790841bab4a0ba2:/gitweb/gitweb.perl#l870
>> 
>> I use HTTP::BrowserDetect package if available and it's ->robot() method.
>> 
>> The fallback is to use *whitelist*, assuming that it would be better to
>> not show "Generating..." page rather than download the wrong thing.
>> I also guess that most (all?) web browsers use "Mozilla compatibile"
>> somewhere in their User-Agent string, thus matching 'Mozilla'.
> 
> Interesting.  http://www.user-agents.org/ seems to suggest that many
> robots do use Mozilla (though I don't think it's worth bending over
> backwards to help them see the page correctly).
> 
> HTTP::BrowserDetect uses a blacklist as far as I can tell.  Maybe in
> the long term it would be nice to add a whitelist ->human() method.
> 
> Cc-ing Olaf Alders for ideas.

Thanks for including me in this.  :)  I'm certainly open to patching the module, but I'm not 100% clear on how  you would want to implement this.  How is ->is_human different from !->is_robot?  To clarify, I should say that from the snippet above, I'm not 100% clear on what the problem is which needs to be solved.

Olaf

--
Olaf Alders
olaf@wundersolutions.com

http://www.wundersolutions.com
http://twitter.com/wundercounter

866 503 2204 (Toll free - North America)
416 944 8306 (direct)
