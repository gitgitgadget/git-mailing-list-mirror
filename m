From: Martin Nordholts <martin@chromecode.com>
Subject: Re: [PATCH] git.el: Make it easy to add unmerged files
Date: Wed, 02 Sep 2009 07:48:07 +0200
Message-ID: <4A9E0717.9040801@chromecode.com>
References: <4A9A92F4.2090209@chromecode.com> <87ws4l47k2.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Wed Sep 02 07:45:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiieY-0007rm-TD
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 07:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755820AbZIBFo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 01:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755790AbZIBFo4
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 01:44:56 -0400
Received: from proxy3.bredband.net ([195.54.101.73]:51187 "EHLO
	proxy3.bredband.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755776AbZIBFoz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 01:44:55 -0400
Received: from iph2.telenor.se (195.54.127.133) by proxy3.bredband.net (7.3.140.3)
        id 49F597CD03339FA2 for git@vger.kernel.org; Wed, 2 Sep 2009 07:44:56 +0200
X-SMTPAUTH-B2: 
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhweADujnUrVcXgmPGdsb2JhbAAIigeRGAEBAQE3vnSEGwU
X-IronPort-AV: E=Sophos;i="4.44,316,1249250400"; 
   d="scan'208";a="40023568"
Received: from c-267871d5.017-113-6c756e10.cust.bredbandsbolaget.se (HELO [192.168.1.2]) ([213.113.120.38])
  by iph2.telenor.se with ESMTP; 02 Sep 2009 07:44:56 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Thunderbird/3.0b3
In-Reply-To: <87ws4l47k2.fsf@wine.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127584>

On 08/30/2009 05:58 PM, Alexandre Julliard wrote:
> Martin Nordholts <martin@chromecode.com> writes:
> 
>> (Resending as I managed to mangle the previous patch despite trying not to...)
>>
>> It is nice and easy to git-add ignored and unknown files in a
>> git-status buffer. Make it equally easy to add unmerged files which is
>> a common use case.
> 
> That's not quite what adding a file means in git.el, unmerged files are
> considered added already, and marking them resolved is done through the
> git-resolve-file command. Of course that was implemented before git
> overloaded the meaning of git-add to mean git-update-index, so maybe we
> should follow the trend and use git-add-file for all index updates. In
> that case git-resolve-file should probably be removed.

Since git instructs the user to use git-add for marking unmerged files
as resolved ("After resolving the conflicts, mark the corrected paths
with 'git add <paths>' or 'git rm <paths>' and commit the result.") and
doesn't even mention git-update-index, I think we should change git.el
accordingly.

But why do we need to also remove and disable git-resolve-file from
git.el? It doesn't hurt to keep that function and the keybinding, does
it?

 / Martin
