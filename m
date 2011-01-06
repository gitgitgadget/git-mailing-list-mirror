From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: log -p hides changes in merge commit
Date: Thu, 06 Jan 2011 15:50:13 -0500
Message-ID: <4D262B05.2060306@cfl.rr.com>
References: <4D25F6BE.7010300@cfl.rr.com> <7vwrmhakdz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 21:45:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pawhg-0002tf-1D
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 21:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407Ab1AFUoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 15:44:55 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:52874 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab1AFUoz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 15:44:55 -0500
Authentication-Results: cdptpa-omtalb.mail.rr.com smtp.user=psusi@cfl.rr.com; auth=pass (PLAIN)
X-Authority-Analysis: v=1.1 cv=Inhw+Jdt7z1D3BivGPfn2aw54OvUEJw5lAn/booRZkE= c=1 sm=0 a=D86Jg8a-DgoA:10 a=8nJEP1OIZ-IA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:17 a=MDdYYv4VsgnpCBNDDtsA:9 a=wMki-pMdweSNHGtAs80w4Azyl2YA:4 a=wPNLvfGTeEIA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:117
X-Cloudmark-Score: 0
X-Originating-IP: 72.242.190.170
Received: from [72.242.190.170] ([72.242.190.170:4911] helo=[10.1.1.235])
	by cdptpa-oedge04.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTPA
	id FF/D8-13137-5C9262D4; Thu, 06 Jan 2011 20:44:53 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vwrmhakdz.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164670>

On 1/6/2011 2:43 PM, Junio C Hamano wrote:
> Depends on the definition of "correctly", but perhaps you have a
> definition different from ours ;-) The "patches" shown with -c/--cc are
> designed to be different from normal diff so that people do not
> accidentally try to apply them with "patch" or "git apply".
> 
> "log -p" omits merge commits by default because diffs of merges are mostly
> not useful for ordinary purposes.  If you are trying to use "log -p" to
> reproduce a (part of) history, perhaps you would want to also study -m
> option.

What I would like to do is be able to review a merge to sign off on it.
 While the full diff against the left parent would be a large and
unhelpful amalgamation of the changes in the merged branch, any
additional changes made during the commit should not be hidden.  This
allows someone performing the merge to effectively sneak in unintended
changes.  I would expect any such changes to be shown by log -p, but
this only seems to happen if you add -c.
