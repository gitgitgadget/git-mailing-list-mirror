From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] branch: allow -f with -m and -d
Date: Fri, 05 Dec 2014 10:02:15 -0800
Message-ID: <xmqqbnniq8k8.fsf@gitster.dls.corp.google.com>
References: <cover.1417699299.git.git@drmicha.warpmail.net>
	<7b1ae15228841d3eaed739e89295ec10a2be45fa.1417699299.git.git@drmicha.warpmail.net>
	<xmqqh9xbtehw.fsf@gitster.dls.corp.google.com>
	<54818FA7.7040102@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Dec 05 19:02:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwxCw-0004ok-Qa
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 19:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbaLESCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 13:02:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61375 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751121AbaLESCS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 13:02:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E053C220B7;
	Fri,  5 Dec 2014 13:02:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qn5B8/5lX6aGW7WoZDn/62lHtW4=; b=uBSTbO
	1JEKQdDekSGTgPBbAAjWlytvMdrL5lJLf527L8JQiCiZWsxbvsx4WwTjM9cpVvmC
	Fybh1Y8ui+iGY8Xct8sydz7D/dTqjh3tuA7L2uiSD1hRqLqKmgFgBw2SkdHBbeQH
	7ifwDK0ZVDdLgKeAatX6VAkOCOxv8L0akZR8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xafSWr0pIr2ZhkCyuyjMLQSRorfvJTaS
	4Vkx9sC9HxI7topFuXl9rcHnBc0mY/Wlb7OqEFr9xFWjab+KFreb9n7oLiW57/LC
	F2bqu7+mbRwSg46J6AvDIHrKxgiyimaXJEXgE/fzjYviQNgXXWyowxpX4QJOAkn3
	DvrjfcXl73w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D74C6220B6;
	Fri,  5 Dec 2014 13:02:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58924220B5;
	Fri,  5 Dec 2014 13:02:16 -0500 (EST)
In-Reply-To: <54818FA7.7040102@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 05 Dec 2014 11:57:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D8ED1A14-7CA8-11E4-AB27-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260879>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> What should "-f -u" and "-f -l" do, then, though?
>> 
>>>  	    list + unset_upstream > 1)
>>>  		usage_with_options(builtin_branch_usage, options);
>>>  
>
> I would say there is nothing to force, so we ignore -f there.

OK, and that is what the updated code does.
