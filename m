From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: RFE: support change-id generation natively
Date: Thu, 24 Oct 2013 08:01:58 +0200
Message-ID: <5268B7D6.5050106@viscovery.net>
References: <2127507934.9293293.1382367063640.JavaMail.root@openwide.fr> <201310212029.01589.thomas@koch.ro> <1382380858.25852.36711509.53CF173C@webmail.messagingengine.com> <201310211249.49568.mfick@codeaurora.org> <xmqqy55lrsoo.fsf@gitster.dls.corp.google.com> <CACsJy8A7r-gsbru0eLxtJbFk2vgqvBH9akHn6e53k=UJbZ1K7Q@mail.gmail.com> <xmqqzjq0q8nl.fsf@gitster.dls.corp.google.com> <CACsJy8CuEvdTu+P-P-kYC0dKQKnjh5sRoevd_hsbqF0796i0xw@mail.gmail.com> <8D1AF6D7-F7AA-4E64-B6B3-3C8C931312C3@codeaurora.org> <CACsJy8BoqWMqGPM8JDny6mxkxZzhWrQ6RYZiNK=vzdwXL4a=vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>, james.moger@gitblit.com,
	Thomas Koch <thomas@koch.ro>,
	Jeremy Rosen <jeremy.rosen@openwide.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Duy Nguyen <pclouds@gmail.com>,
	Nasser Grainawi <nasser@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Oct 24 08:02:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZDzq-0000tC-Ow
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 08:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503Ab3JXGCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 02:02:10 -0400
Received: from so.liwest.at ([212.33.55.16]:62876 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752517Ab3JXGCK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 02:02:10 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VZDzb-0007il-Ij; Thu, 24 Oct 2013 08:02:00 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 23AB016613;
	Thu, 24 Oct 2013 08:01:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <CACsJy8BoqWMqGPM8JDny6mxkxZzhWrQ6RYZiNK=vzdwXL4a=vQ@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236566>

Am 10/24/2013 7:25, schrieb Duy Nguyen:
> On Thu, Oct 24, 2013 at 11:11 AM, Nasser Grainawi <nasser@codeaurora.org> wrote:
>>>> It is not clear to me how you envision to make it work.
>>>
>>> I don't have the source code.
>>
>> Now you do: https://gerrit.googlesource.com/gerrit/+/master/gerrit-server/src/main/resources/com/google/gerrit/server/tools/root/hooks/commit-msg
> 
> Thanks. So you do have tree sha-1 by running "git write-tree". But at
> that point I'm not sure if cache-tree is written down to disk yet, so
> write-tree could be more expensive than necessary (one good point for
> building --change-id in).

Consider that I make a commit with a change-id. Then I rewrite the commit,
but keep the change-id. Then I push the rewritten commit to Gerrit. Gerrit
does not have the objects that the change-id is based on; the change-id is
just a random number and has no other significance. Right?

Why do you go all the length in computing a change-id instead of just
pulling 20 bytes from /dev/random?

That said, I don't think that --change-id option that the user must not
forget to use is any better than a hook that the user must not forget to
install.

-- Hannes
