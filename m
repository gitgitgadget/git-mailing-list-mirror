From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH v2] commit, status: #comment diff output in verbose mode
Date: Sun, 13 Mar 2011 19:34:22 +0100
Message-ID: <AANLkTi=csBKvpBew9QMbD6UA774K_t6h+O4kK1-qa=FC@mail.gmail.com>
References: <1299787140-21472-1-git-send-email-icomfort@stanford.edu>
	<20110310225233.GH15828@sigill.intra.peff.net>
	<7vvczq1o4l.fsf@alter.siamese.dyndns.org>
	<20110311012318.GB15377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ian Ward Comfort <icomfort@stanford.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 13 19:34:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pyq7i-0003mv-H6
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 19:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286Ab1CMSeY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Mar 2011 14:34:24 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33532 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677Ab1CMSeX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Mar 2011 14:34:23 -0400
Received: by vws1 with SMTP id 1so1859728vws.19
        for <git@vger.kernel.org>; Sun, 13 Mar 2011 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Z9NZtaWusrTw2X56eT4bFA8kPRK28DWbre30d9UiJog=;
        b=OEYjagrhJL1dLVZdKVxFILwHGLAQFtNP0W+iUkNvhUyGLySYOGA0Nafv9R/K9L9LNN
         uPCJNrVRsmP2y2E9WmZiQ6bmrLkqXfl+MYuP+YLdXeUdTI1Iz8zD7lwefNgiLo9kfQ9J
         9NrrmmOyhINyFxg7ITI1bfwHsBmdVXu/DfoEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XYd/+QMsr/tWUFZFN2WuNI5fROGzdFgMarBI0hebRWyopc6xxoORay0Z5/MqE9ZAqq
         kyWJvUaTKHLqc5mcUkrSWBeNfKrUN851h8APOaxKL+DDCZirHX+WXE9HuEG7ctrLVOJI
         OdL8tahFPzHiHcxxhCUpsHuFtAGNu4g2lLIzE=
Received: by 10.52.68.18 with SMTP id r18mr5944260vdt.82.1300041262562; Sun,
 13 Mar 2011 11:34:22 -0700 (PDT)
Received: by 10.220.186.205 with HTTP; Sun, 13 Mar 2011 11:34:22 -0700 (PDT)
In-Reply-To: <20110311012318.GB15377@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168975>

On Fri, Mar 11, 2011 at 2:23 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 10, 2011 at 04:45:14PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > One reason to keep the existing behavior is that editors will tend=
 to
>> > syntax-highlight the diff portion without much extra effort (in vi=
m, at
>> > least, the syntax highlighting just includes the diff syntax
>> > highlighting for that section).
>>
>> Hmm, thanks for pointing it out; it indeed is a valid concern.
>>
>> Although I usually strongly resist changes in order to keep the user
>> experience stable, I didn't think about this one, as I don't let the
>> editor syntax highlight anything.

/me too - I find syntax highlighting a nice feature and would prefer it=
 to
stay as it is over using #commented out diff


> I like the proposal for:
>
> =A0# Lines below this one will be removed.
> =A0diff --git ...
>
> which seems to have the best of both worlds, robust and easy for edit=
ors
> to recognize as a diff. For that matter, we could also do "# Lines be=
low
> this one..." for _all_ of the git-status template, but I don't think
> it's necessary. Those lines are already clearly marked with a delimit=
er,
> and I don't think anybody is complaining about them

The advantage of using such line is that it's more unique - IMO it's le=
ss likely
someone writes a commit message with "# Lines below ..." etc then with
"diff --git".

It also makes possible to remove this line and thus include git diff ou=
tput in
commit message.

The downside is probably the need to support i18n for "# Lines below ..=
=2E"

Less magic formats (or formats less magic) is better IMO.

--=20
Piotr Krukowiecki
