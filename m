From: Bernt Hansen <bernt@norang.ca>
Subject: Re: git log -S doesn't find some commits
Date: Tue, 04 Nov 2008 19:29:04 -0500
Organization: Norang Consulting Inc
Message-ID: <877i7jrp67.fsf@gollum.intra.norang.ca>
References: <87fxm7rtb7.fsf@gollum.intra.norang.ca>
	<alpine.DEB.1.00.0811050014310.30769@pacific.mpi-cbg.de>
	<7vod0voy22.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 01:30:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxWI2-0000az-DH
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 01:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537AbYKEA3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 19:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754147AbYKEA3O
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 19:29:14 -0500
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:51836 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102AbYKEA3N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 19:29:13 -0500
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1KxWGm-0008De-26; Wed, 05 Nov 2008 00:29:12 +0000
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.13.8/8.13.8/Debian-3) with ESMTP id mA50T5tk031916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Nov 2008 19:29:06 -0500
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.3/8.14.3/Debian-5) with ESMTP id mA50T5gI014186;
	Tue, 4 Nov 2008 19:29:05 -0500
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.3/8.14.3/Submit) id mA50T44A014185;
	Tue, 4 Nov 2008 19:29:04 -0500
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.mailhop.org/outbound/abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19zNax5XL3pygAtinQAgT9s
In-Reply-To: <7vod0voy22.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 04 Nov 2008 15\:45\:25 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100130>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Tue, 4 Nov 2008, Bernt Hansen wrote:
>>
>>> Commits B, C, and D are not included in the git log -S output even
>>> though with gitk you can see that 'org-publish-validate-link' is in the
>>> patch.
>>
>> It is not sufficient for it to be in the patch, it has to be added or 
>> deleted in whole.  So for example if you had a line
>>
>> 	org-publish-validate-link Hello
>>
>> and you changed it to
>>
>> 	org-publish-validate-link World
>>
>> git log -SWorld will find the commit, but git log 
>> -Sorg-publish-validate-link will not.
>
> It seems nobody has looked at the actual commits, but Dscho got it 80%
> right.
>
> There seems to be a misconception on what -S<foo> does.  It does *NOT*
> grep for string <foo> in the patch text.  It counts number of <foo> in
> preimage and postimage and decides that the commit is worth showing iff
> they differ.
>
> If you look at, for example (B):
>
>     http://repo.or.cz/w/org-mode.git?a=commitdiff;h=837c81ce51
>
> You can see that in org-publish.el, org-publish-validate-link appears once
> as removed and once as added, so the total number of the appearance of the
> symbol in preimage and postimage are the same.

Now I get it :)

Thanks both of you!

Regards,
Bernt
