From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Translations [of Documentation] in Git release?
Date: Mon, 26 Jan 2009 12:38:30 -0800
Message-ID: <7vskn54xbt.fsf@gitster.siamese.dyndns.org>
References: <60646ee10901250941s34f7accem1b74fc201e895a41@mail.gmail.com>
 <m3hc3mxn9d.fsf@localhost.localdomain>
 <Pine.LNX.4.64.0901261426350.7798@ds9.cixit.se>
 <200901261631.18157.jnareb@gmail.com>
 <60646ee10901261158w65b539dida26d2bd3bae6903@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	yasuaki_n@mti.biglobe.ne.jp
To: Dill <sarpulhu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 21:57:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRYWI-0001xY-9K
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 21:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbZAZUz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 15:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbZAZUz4
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 15:55:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50522 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbZAZUzz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 15:55:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C47F11D420;
	Mon, 26 Jan 2009 15:55:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 004FC1D5B5; Mon,
 26 Jan 2009 15:38:31 -0500 (EST)
In-Reply-To: <60646ee10901261158w65b539dida26d2bd3bae6903@mail.gmail.com>
 (sarpulhu@gmail.com's message of "Mon, 26 Jan 2009 12:58:24 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B89175CA-EBEB-11DD-9E74-6E37113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107274>

Dill <sarpulhu@gmail.com> writes:

> On 1/26/09, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Mon, 26 Jan 2009, Peter Krefting wrote:
>>> Jakub Narebski wrote:
>>>
>>> > With GUI translations we just use gettext conventions. I don't know
>>> > any such convention for docs:
>>>
>>> There is a lot of documentation being translated using PO files. po4a -
>>> http://po4a.alioth.debian.org/ - is a nice starting point for that.
>>
>> I'm not sure if XLIFF wouldn't be better format to use to translate
>> _documents_.  Gettext was meant to translate, I think, not very long
>> messages in programs.
>>
>> Also I am not sure how much support this idea has. True, in last Git
>> User's Survey[1] 63% to 76% wanted (parts of) Documentation... but that
>> was out of 325 people who answered this question, with 3236 responses
>> to survey in total, so numbers are more like 6% - 8%.
>>
>> [1] http://git.or.cz/gitwiki/GitSurvey2008
>> [2] http://translate.sourceforge.net/wiki/
>> ...
> I was thinking of handling it like the Linux kernel documentation...?

By this, I understand you mean the model that lets the authors of the
original English documentation be unaware of the presense of translations,
and resulting translated files are placed in Documentation/??_??/ (where
"??_??" are ja_JP, zh_CN, etc.) subdirectory.

The approach obviously risks the translations to go stale very easily, but
gives a nice separation of reponsibility and does not slow down the way
the original documents are updated.  I would actually prefer a directory
structure "Documentation/translated/??_??/" so that people who are not
involved in the translation do not have to see anything below _one_
directory (i.e. "translated").

If you step in as the Documentation translation coordinator to maintain
such a tree structure that I can have as a submodule (or subtree merge) to
git.git tree, you could talk me into updating my tree from time to time
from your tree, but at that point we might actually want to have such a
translation project as a separate and unrelated project.

By the way,

    http://github.com/yasuaki/git-manual-jp.git/

has some Japanese translations (no, I am not involved in this any way, and
I do not know about its current status).

If you look at files in Documentation/ (not Documentation.ja) in that
repository, you can see how they tried to make it easier to update the
translation to match the original documentation set when the original gets
updated.  I do not know how well the approach works in practice, though.
