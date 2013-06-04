From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-daemon: needs /root/.config/git/config?
Date: Tue, 4 Jun 2013 12:10:25 -0700
Message-ID: <20130604191025.GG28153@google.com>
References: <20130604141314.GD22308@pomac.netswarm.net>
 <20130604160815.GB15953@sigill.intra.peff.net>
 <51AE3A88.2080203@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Ian Kumlien <pomac@vapor.com>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 21:10:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujwcs-0000Zm-L2
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 21:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808Ab3FDTKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 15:10:31 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:37752 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab3FDTKa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 15:10:30 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so663324pbc.17
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JMXz16UX1OWmuWQF31fDMc2j4EZPAK7fJJ1btj4or6M=;
        b=siCqmtGb++pYae78+82RZ4yAiZgLupLkaxfrR8F+W81rIAVeaSjpHFldkYG2GUAQ83
         mmaEenInF0FIipfSqd/5Pc2CLknQ+81e1yYhKX8P3OyQ/cPoXrdLirE6cCEK1WTKjaaJ
         chxJSKMiguYjssP0sq4sCPjEYx27w3An8NhyDuwbhKtsz1eaBHRhF8NHzeNFBywmdXIX
         Wxh2JflZb7Za+eOCleqo9Pg4Ft/GMcqEUoKyrAhY22rd3pWaC6lRFvKY/Gkp7fgGMv4X
         zKZFuqx107V4gj5kAo8bnOBV728WXdRiOpiO2IXx5U0llrW3JynNWQ1/XrLpJjnWSEm3
         TzBA==
X-Received: by 10.68.178.229 with SMTP id db5mr29617190pbc.79.1370373029711;
        Tue, 04 Jun 2013 12:10:29 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id cp1sm64303755pbc.42.2013.06.04.12.10.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 12:10:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51AE3A88.2080203@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226395>

Johannes Sixt wrote:
> Am 04.06.2013 18:08, schrieb Jeff King:

>> However, since changing user id and leaving $HOME is so common, there is
>> a patch under consideration to loosen the check only for the case of
>> EACCES on files in $HOME. That commit is 4698c8f (config: allow
>> inaccessible configuration under $HOME, 2013-04-12); it's not yet in any
>> released version of git, though.
[...]
> I've a PHP script in ~/public_html that runs git. Without the mentioned
> patch, the script bails out due to this error. This time it's Apache
> that gets me into trouble because at the time the PHP script and git
> run, $HOME is still /root, but the user identity is not root anymore.
> The patch is direly needed; without it, I need to use 'env
> HOME=/home/j6t /usr/local/bin/git' in my script.

I could be remembering wrong, but I thought it was not so much "under
consideration" as "accepted for 1.8.4".  I haven't heard any
compelling reasons not to apply it.

Would it would make sense against earlier releases as well?

Thanks,
Jonathan
