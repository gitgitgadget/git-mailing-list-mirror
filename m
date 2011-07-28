From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2 3/3] push: Add the --no-recurse-submodules option
Date: Fri, 29 Jul 2011 00:22:56 +0200
Message-ID: <4E31E140.8020105@web.de>
References: <1311790250-32454-1-git-send-email-iveqy@iveqy.com> <1311790250-32454-4-git-send-email-iveqy@iveqy.com> <7vy5zikw6e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	hvoigt@hvoigt.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 00:23:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmYyw-0007Kb-Hv
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 00:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097Ab1G1WXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 18:23:01 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:52397 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756079Ab1G1WXA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 18:23:00 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id C17271961AFF9;
	Fri, 29 Jul 2011 00:22:56 +0200 (CEST)
Received: from [93.240.106.134] (helo=[192.168.178.43])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QmYym-000157-00; Fri, 29 Jul 2011 00:22:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <7vy5zikw6e.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18bvn1rdJFvOJaF1q7TjrJJ9hoJcaCqRwosoKIc
	Cv+Dm2/cB/g0Ecr/GxHtf/m/Dl0cHslpCtFg40S/8OXLx3Rugr
	dJrOz26qPl1iKab+lH9w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178119>

Am 28.07.2011 22:05, schrieb Junio C Hamano:
> Fredrik Gustafsson <iveqy@iveqy.com> writes:
> 
>> This adds the option --no-recurse-submodules to push. That is, git
> 
> I think this needs to be renamed at least for two reasons.
> 
> The name makes it sound as if "push --recurse-submodules" would
> recursively visit the submodules and runs "push" there, but I do not think
> that is what this flag does.

That is because the patch that does this is still in the making ;-)

The cover letter should have mentioned it, but we talked about making push
pretty symmetric to fetch:

- Use "--no-recurse-submodules" if you don't want submodules to be pushed
  (we added that right now so users can disable the behavior the second
  commit introduces)
- Use "--recurse-submodules=on-demand" to push only those submodules where
  new commits have been recorded in the superproject's refs to be pushed
- Use "--recurse-submodules" to unconditionally push everything in the
  submodules too
- Make the default configurable by a "push.recurseSubmodules" option

We'll need another round to discuss how to handle private submodules which
were never intended to be pushed, but I think the general idea of having
fetch and push use similar options makes sense, no?
