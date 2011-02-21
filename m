From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [1.7.5] Let fetch and pull recurse into submodules when new commits
 are recorded
Date: Mon, 21 Feb 2011 18:38:35 +0100
Message-ID: <4D62A31B.7060900@web.de>
References: <7vwrky5f48.fsf@alter.siamese.dyndns.org> <4D5FF264.5050002@web.de> <4D6280F2.5000409@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 18:39:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrZjK-0002aN-01
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 18:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597Ab1BURjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 12:39:11 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:51074 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570Ab1BURjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 12:39:09 -0500
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7439718978557;
	Mon, 21 Feb 2011 18:38:38 +0100 (CET)
Received: from [93.246.44.148] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PrZiY-0004v6-00; Mon, 21 Feb 2011 18:38:38 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D6280F2.5000409@xiplink.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18e2A0dbCSghKjHC+LJ8xuDbeE3k2LasaIfV/2B
	7+3uCrjdHPiByLaWD6MRLzexWZtWZOW98TM+ZzGtukY63hFt8t
	ZofkkvkFYi5CSxuEPF0w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167497>

Am 21.02.2011 16:12, schrieb Marc Branchaud:
> On 11-02-19 11:40 AM, Jens Lehmann wrote:
>> Proposal:
>> Add a new "on-demand" mode to fetch and pull and make it the default.
>>
>> When using the new "on-demand" mode every time new commits are fetched
>> in the superproject they will be parsed for submodule commits. If these
>> commits aren't present in a populated submodule, run "git fetch" inside
>> that submodule. (Also see this thread for an in depth discussion:
>> http://article.gmane.org/gmane.comp.version-control.git/158979/ )
>>
>> Additionally change "git submodule update" to only then run fetch in a
>> submodule when the commit it wants to check out is not already present
>> there.
>>
>> This behavior can be configured per submodule, per repo and globally.
>>
>> Advantages:
>> * Disconnected operation. Right now it is really easy to forget to fetch
>>   all submodules before you get on a plane, possibly leaving you unable
>>   to check out certain revisions.
> 
> I support the proposal, but just to be clear I'd rephrase that advantage as:
> 
> Disconnected operation. Right now it is really easy to forget to update
> populated submodules before you get on a plane, possibly leaving you unable
> to check out certain revisions.
> 
> (Obviously, I think the only-works-on-already-populated-submodules part is
> very important.)

Thanks and yes, that is exactly what this proposal is about.
