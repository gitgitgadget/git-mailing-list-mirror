From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [PATCH v4 1/6] t9001: non order-sensitive file comparison
Date: Wed, 8 Jun 2016 21:19:38 +0200
Message-ID: <a0222724-673f-c07d-96fa-fab227955858@grenoble-inp.org>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
 <20160608130142.29879-2-samuel.groot@grenoble-inp.org>
 <xmqqmvmvmwh7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, aaron@schrab.com, e@80x24.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 21:19:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAj0z-0002vt-B6
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 21:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161967AbcFHTTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 15:19:40 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:44929 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161014AbcFHTTj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 15:19:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id C0D3B222F;
	Wed,  8 Jun 2016 21:19:37 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yvTVVBJuV6PF; Wed,  8 Jun 2016 21:19:37 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id B0C6A2167;
	Wed,  8 Jun 2016 21:19:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id AE38A2066;
	Wed,  8 Jun 2016 21:19:37 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a2fP7SgbU6GM; Wed,  8 Jun 2016 21:19:37 +0200 (CEST)
Received: from wificampus-030012.grenet.fr (wificampus-030012.grenet.fr [130.190.30.12])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 8F7A12064;
	Wed,  8 Jun 2016 21:19:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <xmqqmvmvmwh7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296836>

On 06/08/2016 07:17 PM, Junio C Hamano wrote:
> Here is an illustration of an organization that I think would be
> easier to read, and would result in a more readable patch when
> modification is made on top.  The first two hunks collapse the
> overall "setup" steps that appear as three separate tests into a
> single "setup" test.  The last hunk that begin at -83/+79 collapses
> a logically-single test that is split across three into one, and
> makes the order of things done in the test to (1) set an
> expectation, (2) execute the command and (3) compare the result with
> the expectation.

I totally agree. (1), (2) and (3) aren't even always in that order, some 
tests are very confusing.

> I am not going to commit this myself, because I do not want to
> create conflicts with the change your topic is trying to do, and
> besides, almost all the remainder of the tests follow "one logical
> test split into three" pattern and need to be corrected before this
> "illustration" can become a real patch.
>
> I do not mind if you take it and complete it as a preliminary
> clean-up step in your series; or you can "keep it in mind, but
> ignore it for now", in which case this can be a "low hanging fruit"
> somebody else, hopefully somebody new to the development community,
> can use to dip their toes ;-)

As said in my other reply, I will put this one aside for now, but t9001 
definitely deserves its own cleanup patch series.
