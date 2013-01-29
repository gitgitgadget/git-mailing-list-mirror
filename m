From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH v2 0/4] Auto-generate mergetool lists
Date: Tue, 29 Jan 2013 12:56:58 +0100
Message-ID: <ke8de9$lk5$1@ger.gmane.org>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com> <7v38xm12kk.fsf@alter.siamese.dyndns.org> <CAJDDKr7sQKDNPpaFJi+en479TF=aLXL2pvXODeo6CC3xD1KMGw@mail.gmail.com> <7vr4l6yrd3.fsf@alter.siamese.dyndns.org> <CAJDDKr75K3RGgU79nrznbpjQMLQGkDs=W8XEofURNsS1X1bvjg@mail.gmail.com> <20130128210136.GC7498@serenity.lan> <7vk3qxugdg.fsf@alter.siamese.dyndns.org> <20130128222147.GD7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 12:57:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U09ol-0007Hr-Jg
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 12:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966Ab3A2L5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 06:57:14 -0500
Received: from plane.gmane.org ([80.91.229.3]:60833 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755854Ab3A2L5M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 06:57:12 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1U09od-0007FJ-Uw
	for git@vger.kernel.org; Tue, 29 Jan 2013 12:57:27 +0100
Received: from dsdf-4db557c4.pool.mediaways.net ([77.181.87.196])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 12:57:27 +0100
Received: from jojo by dsdf-4db557c4.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 12:57:27 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db557c4.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214930>

John Keeping wrote:
> On Mon, Jan 28, 2013 at 01:50:19PM -0800, Junio C Hamano wrote:
>> What are the situations where a valid user-defined tools is
>> unavailable, by the way?
>
> The same as a built-in tool: the command isn't available.
>
> Currently I'm extracting the command word using:
>
>    cmd=$(eval -- "set -- $(git config mergetool.$tool.cmd); echo
> \"$1\"")

Shouldnt this work?
cmd=$((git config "mergetool.$tool.cmd" || git config "difftool.$tool.cmd") 
| awk '{print $1}')


> (it's slightly more complicated due to handling difftool.$tool.cmd as
> well, but that's essentially it).  Then it just uses the same "type
> $cmd" test as for built-in tools.
>
> I don't know if there's a better way to extract the first word, but
> that's the best I've come up with so far.
>
>
> John 
