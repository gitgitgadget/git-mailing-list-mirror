From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] git-send-email.perl: Really add angle brackets to  In-Reply-To if necessary
Date: Sun, 09 Dec 2007 10:53:46 -0800
Message-ID: <86aboju2bp.fsf@blue.stonehenge.com>
References: <1197219900-19334-1-git-send-email-mh@glandium.org>
	<1197220648-20433-1-git-send-email-mh@glandium.org>
	<7v63z7rb87.fsf@gitster.siamese.dyndns.org>
	<851w9vsp8o.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Dec 09 19:54:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1RI2-0007IM-VJ
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 19:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbXLISxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 13:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbXLISxs
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 13:53:48 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:38122 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbXLISxr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 13:53:47 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 58E281DE63D; Sun,  9 Dec 2007 10:53:46 -0800 (PST)
x-mayan-date: Long count = 12.19.14.16.1; tzolkin = 11 Imix; haab = 9 Mac
In-Reply-To: <851w9vsp8o.fsf@lola.goethe.zz> (David Kastrup's message of "Sun, 09 Dec 2007 19:21:43 +0100")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67650>

>>>>> "David" == David Kastrup <dak@gnu.org> writes:

>>> $initial_reply_to = $_;
>>> -	$initial_reply_to =~ s/^\s+<?/</;
>>> -	$initial_reply_to =~ s/>?\s+$/>/;
>>> }
>> 
>> I wonder what the original rationale for these \s+ was.
>> Will apply, anyway.  Thanks.

David> The original line read

David> 	$initial_reply_to =~ s/(^\s+|\s+$)//g;

David> and was used just for stripping spaces (no stripping necessary when
David> there is no space, so \s+ was ok).  The change was supposed to work
David> on the brackets, too.

David> That Mike got bitten here is proof that the original idea had merit.
David> Too bad the implementation did not actually work.

I think what you were trying to do would work with:

  for ($initial_reply_to) {
      s/^\s*<?/</;
      s/>?\s*$/>/;
  }

Untested, but I get this stuff right most of the time. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
