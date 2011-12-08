From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] bundle: rewrite builtin to use parse-options
Date: Thu, 8 Dec 2011 11:59:14 -0600
Message-ID: <20111208175913.GK2394@elie.hsd1.il.comcast.net>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323349817-15737-4-git-send-email-artagnon@gmail.com>
 <20111208163946.GB2394@elie.hsd1.il.comcast.net>
 <CALkWK0mmjKSzSbxq2i7=JvcB4LTro-MYDCwQLUUwqcf8qS0zPA@mail.gmail.com>
 <20111208170319.GD2394@elie.hsd1.il.comcast.net>
 <CALkWK0m89D02aku8J0OXbpyrovHCOpsYS4Qpx2jH-pFG4rOG2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 18:59:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYiFe-00035W-Kc
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 18:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab1LHR7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 12:59:18 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53014 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab1LHR7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 12:59:17 -0500
Received: by ggnr5 with SMTP id r5so2276697ggn.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 09:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=n/FGoe8EGKyttfvjhUg7yy0VGRMUJ2kQugL3WsVGdGs=;
        b=tsTrA7njznOaIOVpro+PCkqbL7Yk2ENUxCTS7as2in5moe7CDtCuefIogvnWKkaDee
         MFMOHAfBsdVdcc+u/CXVq/wzugw4RwssKLt01DUA3Vvc6pMlOsNQjO4mREvRgcqpgORb
         3lQ4QhgWoSZjjZF6U6z1qyRz4JeSkVzDOReAg=
Received: by 10.100.5.9 with SMTP id 9mr1035617ane.79.1323367157143;
        Thu, 08 Dec 2011 09:59:17 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id l16sm16384697ane.2.2011.12.08.09.59.15
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 09:59:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0m89D02aku8J0OXbpyrovHCOpsYS4Qpx2jH-pFG4rOG2A@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186581>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:

>> Having to type "--" or prefix with "./" to escape ordinary filenames
>> that do not start with "-" would be completely weird.
>
> Hm, do you have any suggestions to work around this?  Can we use
> something like a parse-stopper after the the first subcommand is
> encountered, and treat the next argument as a non-subcommand (filename
> or whatever else)?

What's the desired behavior?  Then we can talk about how to implement it.

If the goal is "use parse-options for a command that has subcommands",
see builtin/notes.c.
