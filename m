From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] Prompt for a username when an HTTP request 401s
Date: Fri, 19 Mar 2010 10:34:16 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1003191033022.15750@tvnag.unkk.fr>
References: <d411cc4a1003182041p67a93bf6i1528a8eaaab5c805@mail.gmail.com> <be6fef0d1003190213m48b6c91dx5cbd489cf798dacc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1470944514-1674259414-1268991256=:15750"
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 10:43:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsYk2-0000p7-LW
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 10:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566Ab0CSJnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 05:43:37 -0400
Received: from giant.haxx.se ([83.168.254.42]:44398 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128Ab0CSJng (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 05:43:36 -0400
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Mar 2010 05:43:36 EDT
Received: from giant.haxx.se (giant.haxx.se [83.168.254.42])
	by giant.haxx.se (8.14.3/8.14.3/Debian-9) with ESMTP id o2J9YG2e019785;
	Fri, 19 Mar 2010 10:34:16 +0100
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <be6fef0d1003190213m48b6c91dx5cbd489cf798dacc@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142572>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1470944514-1674259414-1268991256=:15750
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 19 Mar 2010, Tay Ray Chuan wrote:

>> When an HTTP request returns a 401, Git will currently fail with a 
>> confusing message saying that it got a 401.  This changes http_request to 
>> prompt for the username and password, then return HTTP_REAUTH so 
>> http_get_strbuf can try again.  If it gets a 401 even when a user/pass is 
>> supplied, http_request will now return HTTP_NOAUTH which remote_curl can 
>> then use to display a more intelligent error message that is less 
>> confusing.
>
> how are you getting 401s? Recently, git set the CURL_AUTH_ANY option, so if 
> the correct credentials are passed, curl should have "hid" the 401 from us.

That's correct. It should hide the 401 in the sense that it should try to 
continue and do the correct authentication procedure and only if that fails it 
should end up with an actual 401 end result.

-- 

  / daniel.haxx.se
---1470944514-1674259414-1268991256=:15750--
