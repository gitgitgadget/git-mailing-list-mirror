From: Ryan Phillips <ryan@trolocsis.com>
Subject: Re: git-http-backend and Authenticated Pushes
Date: Tue, 9 Mar 2010 20:13:46 -0600
Message-ID: <46a47f951003091813p768fdb58v454f2553a8b6ed8@mail.gmail.com>
References: <46a47f951003090908s62512bd7xcbb707205958e004@mail.gmail.com>
	 <20100309192726.GA12461@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 10 03:13:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpBQo-0002zU-IU
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 03:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755563Ab0CJCNu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Mar 2010 21:13:50 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36640 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755522Ab0CJCNs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Mar 2010 21:13:48 -0500
Received: by gyd8 with SMTP id 8so313194gyd.19
        for <git@vger.kernel.org>; Tue, 09 Mar 2010 18:13:47 -0800 (PST)
Received: by 10.91.164.17 with SMTP id r17mr1016382ago.0.1268187227111; Tue, 
	09 Mar 2010 18:13:47 -0800 (PST)
In-Reply-To: <20100309192726.GA12461@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 9, 2010 at 1:27 PM, Shawn O. Pearce <spearce@spearce.org> w=
rote:
> Ryan Phillips <ryan@trolocsis.com> wrote:
>> I'm trying to follow the git-http-backend man page on setting up
>> authenticated pushes to my apache server. Pulls work fine, and fully
>> authenticated pushes work fine. However, when I try and setup
>> anonymous pulls and authenticated pushes the push fails.
>>
>> I believe the culprit is this 403 error:
>>
>> 192.168.1.1 - - [09/Mar/2010:09:01:43 -0800] "GET
>> /git/test.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 403 - "=
-"
>> "git/1.7.0.2.dirty"
>
> Ugh. =A0Looks like I didn't design this thing right.
>
> The backend wants you to be authenticated before it will service
> the git-receive-pack advertisement. =A0Even though its the same
> data as the git-upload-pack advertisement (but slightly different
> capability strings).
>
> Maybe we should consider doing something like this patch so that
> the advertisement under info/refs?service=3Dgit-receive-pack can be
> sent without needing authentication. =A0My only hesitation is this
> makes it harder for the client to setup the authentication before
> it needs to transmit the pack file, which may mean it needs to send
> the pack twice.
>

Thank you everyone for your response.

Shawn: That patch does fix the issue for now.

Regards,
Ryan
