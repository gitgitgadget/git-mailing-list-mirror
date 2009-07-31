From: "George Spelvin" <linux@horizon.com>
Subject: Re: Request for benchmarking: x86 SHA1 code
Date: 31 Jul 2009 07:31:00 -0400
Message-ID: <20090731113100.17584.qmail@science.horizon.com>
References: <40aa078e0907310411k54dc58fbq9a938c489df56b68@mail.gmail.com>
Cc: git@vger.kernel.org
To: kusmabite@googlemail.com, linux@horizon.com
X-From: git-owner@vger.kernel.org Fri Jul 31 13:31:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWqKM-0000iZ-8N
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 13:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbZGaLbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 07:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbZGaLbC
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 07:31:02 -0400
Received: from science.horizon.com ([71.41.210.146]:34994 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752029AbZGaLbB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 07:31:01 -0400
Received: (qmail 17585 invoked by uid 1000); 31 Jul 2009 07:31:00 -0400
In-Reply-To: <40aa078e0907310411k54dc58fbq9a938c489df56b68@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124547>

> $ make
> make: *** No rule to make target `sha1-586.o', needed by `586test'.  Stop.
>
> What did I do wrong? :)
> Would it be easier if you pushed it out somewhere?

H'm.... It *should* do

perl sha1-586.pl elf > sha1-586.s
as --32  -o sha1-586.o sha1-586.s
gcc -m32 -W -Wall -Os -g -o 586test sha1test.c sha1-586.o
(And likewise for the "x86test" binary.)

which is what happened when I tested it.  Obviously I have something
non-portable in the Makefile.

You could try "make sha1-586.s" and "sha1-586.o" and see which rule is
f*ed up.

Um, you *are* in a directory which contains a sha1-586.pl file, right?


Thanks!
