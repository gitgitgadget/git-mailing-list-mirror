From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [RFC/PATCH 2/3] add a library of code for producing structured output
Date: Sun, 11 Apr 2010 21:46:18 +0100
Message-ID: <aae50060001ba0a214ed71ceff3fa480@212.159.54.234>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk> <20100411113733.80010.3767.julian@quantumfyre.co.uk> <7vy6gtonwt.fsf@alter.siamese.dyndns.org> <91d4c9c4ecdd32166bedb6dc0bd007d6@212.159.54.234> <m3y6gtg24x.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Eric Raymond <esr@thyrsus.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 22:46:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1432-0007UY-Bb
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 22:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952Ab0DKUqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 16:46:21 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:56948 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752707Ab0DKUqU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 16:46:20 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 69261819C6D7;
	Sun, 11 Apr 2010 21:46:13 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 2D9FF20CF4F;
	Sun, 11 Apr 2010 21:46:19 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vvxsa9LPq72M; Sun, 11 Apr 2010 21:46:18 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 913DA20CF4C;
	Sun, 11 Apr 2010 21:46:18 +0100 (BST)
In-Reply-To: <m3y6gtg24x.fsf@localhost.localdomain>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144683>

On Sun, 11 Apr 2010 13:34:59 -0700 (PDT), Jakub Narebski
<jnareb@gmail.com>
wrote:
> Julian Phillips <julian@quantumfyre.co.uk> writes:
>> On Sun, 11 Apr 2010 11:16:18 -0700, Junio C Hamano <gitster@pobox.com>
>> wrote:
>>> Julian Phillips <julian@quantumfyre.co.uk> writes:
>>> 
>>>> Add a library that allows commands to produce structured output in
any
>>>> of a range of formats using a single API.
>>>>
>>>> The API includes an OPT_OUTPUT and handle_output_arg so that the
>>>> option handling for different commands will be as similar as
possible.
>>> 
>>> I was hoping that the existing low-level -z routines (e.g. "diff-*
-z")
>>> follow similar enough patterns to have a corresponding output-z.c and
be
>>> handled inside output.c library.  But that is not a requirement, just
>>> "would have been nicer if the original were written that way".
>> 
>> As the API currently stands, I don't think it would be possible to
>> recreate the existing output of -z, as the separator between values is
>> not
>> constant.  I haven't really looked into whether the output is
completely
>> incompatible with structured output though (i.e. could -z be supported
by
>> adding one or two functions to the API?).
> 
> What about the new(ly) proposed -Z output in one of its variants,
> namely with single NUL ("\0") as field separator, and double NUL
("\0\0")
> as a record terminator?

That should be much easier.  Though actually I am fairly close to getting
_all_ output from ls-tree going through the output library ... (i.e. even
the normal no-option output).  I don't know what people's opinion on this
approach is, but I thought it was worth a try anyway.

-- 
Julian
