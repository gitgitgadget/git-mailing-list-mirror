From: Geert Bosch <bosch@adacore.com>
Subject: Re: t9401 fails with OS X sed
Date: Thu, 25 Oct 2012 01:04:11 -0400
Message-ID: <F721B376-F4E6-4274-9A6E-BD1CFCBDA39F@adacore.com>
References: <609AC6E7-45CD-4472-B1DC-FBB785D6B815@gernhardtsoftware.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 07:12:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRFji-0006IF-3c
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 07:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295Ab2JYFLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 01:11:49 -0400
Received: from rock.gnat.com ([205.232.38.15]:39818 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068Ab2JYFLs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2012 01:11:48 -0400
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Oct 2012 01:11:48 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id AA8651C7F24;
	Thu, 25 Oct 2012 01:04:10 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at gnat.com
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id uXt+SRlGPfDY; Thu, 25 Oct 2012 01:04:10 -0400 (EDT)
Received: from [10.0.1.9] (sdsl-216-220-103-155.dsl.bway.net [216.220.103.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTPSA id 797471C7DDA;
	Thu, 25 Oct 2012 01:04:10 -0400 (EDT)
In-Reply-To: <609AC6E7-45CD-4472-B1DC-FBB785D6B815@gernhardtsoftware.com>
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208341>


On Oct 24, 2012, at 23:54, Brian Gernhardt <brian@gernhardtsoftware.com> wrote:

> It works if I change \s to [[:space:]], but I don't know how portable that is.

As \s is shorthand for the POSIX character class [:space:], I'd say the latter
should be more portable: anything accepting the shorthand should also accept
the full character class. If not, you probably only care about horizontal tab
and space, for which you could just use a simple regular expression. Just a
literal space and tab character between square brackets is probably going to be
most portable, though not most readable.

  -Geert