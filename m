From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 4/4 v3] Add cat-blob report fifo from fast-import to
 remote-helper.
Date: Sat, 21 Jul 2012 10:44:37 -0500
Message-ID: <20120721154437.GC19860@burratino>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <2448876.O3MA5kWbuX@flobuntu>
 <20120721144834.GB19860@burratino>
 <3246520.u1PcGtbf0N@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 17:44:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsbrR-0006jf-8o
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 17:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524Ab2GUPor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 11:44:47 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:37538 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab2GUPoq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 11:44:46 -0400
Received: by gglu4 with SMTP id u4so4714107ggl.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 08:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=b8M0O6IvHExWVslPYIrbaiN5YXfO5aO2+cyFOT4/mvI=;
        b=dZ2w1he4ie3gOzhqVemZ4N9DB5rcvWDvJTO96G+Emwx+W1MdBUMqGS1/KusH3xJpt+
         u/jLmYpYZRxfICampALr99wKin6n5gJZnaKvMZewaXJUerM174vvKr6GF0wCPxm0KTBm
         FctMSYEwcXX7ncsgCb7N98/hqVh7Fxwz4yMWP0mGAh45+dohs2MgRiiXsVCNQTVRx+B6
         Tcz4AA+uZ6dxfkSc4EC6+YCeZVbr3UjHdiBErTI9o02UgeEpLwpa+rbR7o4hOXldSqts
         Rv/icgpXzbihmZl49jcdTNCCOcla7KnaYIHJDcq0kG+SkvzKc4++JYbadfL19+cdoCQg
         YVSg==
Received: by 10.50.157.196 with SMTP id wo4mr1460664igb.22.1342885485739;
        Sat, 21 Jul 2012 08:44:45 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id uy3sm1621382igc.14.2012.07.21.08.44.44
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 08:44:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3246520.u1PcGtbf0N@flobuntu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201812>

Florian Achleitner wrote:
> On Saturday 21 July 2012 09:48:34 Jonathan Nieder wrote:

>> To sum up: I think we should just stick to pipes --- why all this fifo
>> complication?
>
> People didn't like pipe variant (prexec_cb not being compatible to windows' 
> process creation model), so I learned about fifos and implemented a (basic) fifo 
> variant. *shrug*

Ok, can you elaborate on that?  What does it mean that preexec_cb is
not compatible to windows' process creation model?  Don't the people
of the future working on this code deserve to know about that, too, so
they don't break it?

Come on --- I'm not asking these questions just to make your life
difficult.  Please make it easy to understand your code changes and to
keep them maintained.
