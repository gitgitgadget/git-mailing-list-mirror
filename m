From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow shell scripts to run with non-Bash /bin/sh
Date: Fri, 21 Sep 2007 23:58:22 -0700
Message-ID: <7vd4wbgp9t.fsf@gitster.siamese.dyndns.org>
References: <20070921214346.GF97288@void.codelabs.ru>
	<7vlkazh1ji.fsf@gitster.siamese.dyndns.org>
	<20070921214346.GF97288@void.codelabs.ru>
	<7v8x6zinjf.fsf@gitster.siamese.dyndns.org>
	<20070922035434.GA99140@void.codelabs.ru>
	<86tzpnwdha.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Sep 22 08:58:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYywn-0008J0-WB
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 08:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759980AbXIVG6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 02:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757959AbXIVG6c
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 02:58:32 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:47763 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756724AbXIVG6c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 02:58:32 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B223135ED3;
	Sat, 22 Sep 2007 02:58:47 -0400 (EDT)
In-Reply-To: <86tzpnwdha.fsf@lola.quinscape.zz> (David Kastrup's message of
	"Sat, 22 Sep 2007 06:06:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58918>

David Kastrup <dak@gnu.org> writes:

> Eygene Ryabinkin <rea-git@codelabs.ru> writes:
>
>>> That is, what does the shell say if you do this?
>>> 
>>> 	case Ultra in
>>>         Super)
>>>         	false ;;
>>> 	Hyper)
>>>         	true ;;
>>> 	esac &&
>>>         echo case returned ok
>>
>> It says 'case returned ok', so I will try to understand why it
>> works here and does not work in the 'while' construct.
>
> What you actually need to do is
>
> false
> case Ultra in
>    Super)
>    	false ;;
> Hyper)
>    	true ;;
> esac && echo case returned ok

AHHHHHH.

Is "case" supposed to be transparent?
