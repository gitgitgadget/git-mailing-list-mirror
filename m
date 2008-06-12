From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Thu, 12 Jun 2008 13:51:25 -0700
Message-ID: <7vlk1az8aa.fsf@gitster.siamese.dyndns.org>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <7vzlpqza0t.fsf@gitster.siamese.dyndns.org> <279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
To: "Eric Raible" <raible@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 22:52:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6tmY-00041g-AQ
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 22:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755067AbYFLUvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 16:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754990AbYFLUvg
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 16:51:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689AbYFLUvf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 16:51:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 37F523D30;
	Thu, 12 Jun 2008 16:51:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 527AF3D2D; Thu, 12 Jun 2008 16:51:27 -0400 (EDT)
In-Reply-To: <279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com>
 (Eric Raible's message of "Thu, 12 Jun 2008 13:35:10 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 57B2D3B2-38C1-11DD-823E-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84796>

"Eric Raible" <raible@gmail.com> writes:

> On Thu, Jun 12, 2008 at 1:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Wincent Colaiuta <win@wincent.com> writes:
>>
>>> So yes, branches _are_ better and more appropriate for long term
>>> storage than stashes, but even so I don't think it's right for us to
>>> risk throwing away information that the user explicitly stashed and
>>> expected Git to look after for them.
>>
>> Yes, but for a limited amount of time.
>
> A limited amount of time?  Why is that?  Can you give a rationale which
> at least addresses Wincent's points?

Perhaps

 http://thread.gmane.org/gmane.comp.version-control.git/84665/focus=84670

The user explicitly asks to stash it for a while, where the definition of
the "while" comes from reflog's retention period.
