From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/8] revert: separate out parse errors logically
Date: Wed, 11 Jan 2012 18:08:14 +0530
Message-ID: <CALkWK0mubn6+7E09DMgVuFfhHeZfXamLkkOwAPAPgy3s2q9=PA@mail.gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-1-git-send-email-artagnon@gmail.com> <1326212039-13806-5-git-send-email-artagnon@gmail.com>
 <20120110190311.GD22184@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 13:38:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkxRx-0005uL-Mu
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 13:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757362Ab2AKMih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 07:38:37 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:45427 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872Ab2AKMig (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 07:38:36 -0500
Received: by werm1 with SMTP id m1so475206wer.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 04:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MYMTP/LRvcyx0aXfZorNwZDD26khp4NRp0dvWT94rEI=;
        b=vcXmtoC6D5H958ADtdGaaYsDOsV1zmDKZ999ZWEvVmuKw/3HXC7DD8QMGxhkzGu0c5
         sIO0xb30iX0zHz6JNtPcRC7ceLKwKCtZoXehvbF8YaTWhaOrHVpHB7f+Yck7F7H4yXxt
         dWZFzg5MeAiSqjoX0O/mRzowJpt8aM9rTDL1o=
Received: by 10.216.134.69 with SMTP id r47mr10935038wei.17.1326285515527;
 Wed, 11 Jan 2012 04:38:35 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Wed, 11 Jan 2012 04:38:14 -0800 (PST)
In-Reply-To: <20120110190311.GD22184@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188359>

New commit message.

    revert: simplify insn parsing logic

    Our instruction sheet parser first looks for a valid action by
    checking that the buffer starts with either "pick" or "revert".  Then,
    it looks for either spaces or tabs before looking for the object name,
    erroring out if it doesn't find any.  Simplify this logic without
    making any functional changes by looking for ("pick " or "pick\t") or
    ("revert " or "revert\t") in the first place.

-- Ram
