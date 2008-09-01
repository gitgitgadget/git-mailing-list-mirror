From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] for-each-ref: `:short` format for `refname`
Date: Mon, 01 Sep 2008 14:28:17 -0700
Message-ID: <7v7i9vv9n2.fsf@gitster.siamese.dyndns.org>
References: <7vprnpbqmo.fsf@gitster.siamese.dyndns.org>
 <1220186467-24623-1-git-send-email-bert.wesarg@googlemail.com>
 <20080901131523.GA6739@neumann>
 <36ca99e90809010713h7c673d10j6addd1624a655371@mail.gmail.com>
 <36ca99e90809011052s568fa6e4y89e56769f63806c1@mail.gmail.com>
 <20080901191051.GD7482@spearce.org>
 <36ca99e90809011410w646cc6eajb3063ea3501f173c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	=?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Bert Wesarg" <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 23:34:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaH2K-0001cb-LK
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 23:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbYIAV21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 17:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbYIAV21
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 17:28:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbYIAV20 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 17:28:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 35E775A2E2;
	Mon,  1 Sep 2008 17:28:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 843595A2BF; Mon,  1 Sep 2008 17:28:19 -0400 (EDT)
In-Reply-To: <36ca99e90809011410w646cc6eajb3063ea3501f173c@mail.gmail.com>
 (Bert Wesarg's message of "Mon, 1 Sep 2008 23:10:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E9032764-786C-11DD-BD18-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94611>

"Bert Wesarg" <bert.wesarg@googlemail.com> writes:

> On Mon, Sep 1, 2008 at 21:10, Shawn O. Pearce <spearce@spearce.org> wrote:
> ...
>> You can still get ambiguous names.  Avoiding them requires going
>> through all refs and building their short forms, then using the
>> full ref name for any ref which had more than one name shorten to
>> the same string.  Ugly, but implementable, and probably something
>> that should be considered.
>
> What about: try the list backwards until the first match, than try the
> matched part (this what %.*s matched) with the forward list, if both
> give the same pattern, its not disambiguous. If not try the next
> pattern backwards.

How does it catch the case where you have both 'xyzzy' branch and 'xyzzy'
tag, which is the point of disambiguation issue Shawn raised?
