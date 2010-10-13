From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH v2 0/3] Teach fetch and pull to recursively fetch submodules too
Date: Wed, 13 Oct 2010 13:11:34 -0700
Message-ID: <2C7BF9BF-870D-40B8-8379-8168FCDD2B64@sb.org>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de> <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org> <4C963D00.9050207@web.de> <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org> <4CAB8DDF.8080004@web.de> <FB03A7DB-67D2-4EAE-A0F0-2F3E3CEA9878@sb.org> <4CB0BFDB.7010503@web.de> <4CB5C6D8.1070108@xiplink.com> <4CB6093F.3040800@web.de> <1691DBFD-6075-479E-8847-EB4595BB9E10@sb.org> <4CB61137.6030502@web.de>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 13 22:11:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P67g1-0007Sp-V2
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 22:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140Ab0JMULj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 16:11:39 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35005 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000Ab0JMULi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Oct 2010 16:11:38 -0400
Received: by pvc7 with SMTP id 7so448313pvc.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 13:11:37 -0700 (PDT)
Received: by 10.142.204.4 with SMTP id b4mr8044483wfg.45.1287000697816;
        Wed, 13 Oct 2010 13:11:37 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id q13sm12041201wfc.5.2010.10.13.13.11.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 13:11:36 -0700 (PDT)
In-Reply-To: <4CB61137.6030502@web.de>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158975>

On Oct 13, 2010, at 1:06 PM, Jens Lehmann wrote:

> Am 13.10.2010 21:34, schrieb Kevin Ballard:
>> On Oct 13, 2010, at 12:32 PM, Jens Lehmann wrote:
>> 
>>>>> There are use cases like mine where automatic recursion is just the right
>>>>> thing to do. But I would be fine with having to turn the recursion on
>>>>> explicitly in the configuration if most people think recursion is not a
>>>>> desirable default. It would be really nice to hear from other submodule
>>>>> users what they think about that ...
>>>> 
>>>> I tend to think that the right default for fetch is to employ the same level
>>>> of recursion that was used for the initial clone.  So if the clone was made
>>>> with --recursive then fetch should default to using --recursive.
>>> 
>>> That's a very interesting idea.
>> 
>> I'm not sure it's correct though. For example, with my scenario every single submodule is required for a correct build, but most submodules should definitely not be updated unless their parent submodule updates its gitlink. So --recursive is recommended for `git clone`, but a non-recursive fetch would be the correct behavior going forward.
> 
> For *your* use case it might not be correct, but for others it may very
> well be.

My inclination is to say recursively fetching submodules is a choice many maintainers may want to make, but not something any simple user of a repo will want to do. If I find a neat project out there and `git clone --recursive` it, there's no reason to believe I'll want to track updates to its submodules, as I have no plans on ever modifying this repo myself or creating any commits.

-Kevin Ballard