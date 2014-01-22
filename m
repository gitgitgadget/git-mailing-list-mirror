From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 06/11] git p4 test: run as user "author"
Date: Tue, 21 Jan 2014 20:26:46 -0500
Message-ID: <CAPig+cRJ+MqrBqGYsVmBTzix9baPOkRLKFHv+6J=PnsOv4vkiw@mail.gmail.com>
References: <1390346208-9207-1-git-send-email-pw@padd.com>
	<1390346208-9207-7-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 02:26:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5mai-0003KV-Gd
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 02:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603AbaAVB0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 20:26:48 -0500
Received: from mail-la0-f43.google.com ([209.85.215.43]:48932 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494AbaAVB0s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 20:26:48 -0500
Received: by mail-la0-f43.google.com with SMTP id pv20so842542lab.2
        for <git@vger.kernel.org>; Tue, 21 Jan 2014 17:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=NBARUX2Jaof8UCZjC/P8Ot6B9qH5/Xgr92avL+nVznM=;
        b=bhpEhzIir9tdx3QwVfjTjiMtBNLkmE357B9KiNNnY5lw8Pbg2xKqIo6bOwSTr4iqda
         BM0XIkye+FJncLqM0ZT5tezuvJ/lZgDESLu5cS+76Frm4Fe38/vsQ2fep1R5Aj7q2xly
         Ffz5xQ+dW3YT1hszxWwMATht2OyE+gYNKjI9SnqyuOgp19NAONPkbcTsEejpBlOlSstr
         CFc39YfN8yv1NGQZhqatZDY8V6EI3OYN5iJiIdhIYG2BeXGCuG5B8meaCzgmEDbtu+Yz
         BrPodaD/2wg4sngm/ZNK6EZsy3+Ttc9mfqFKE8phfDUIDEIXbc8cbOQiawzm35Ob8+KJ
         xLRA==
X-Received: by 10.152.22.201 with SMTP id g9mr18640952laf.27.1390354006797;
 Tue, 21 Jan 2014 17:26:46 -0800 (PST)
Received: by 10.114.81.106 with HTTP; Tue, 21 Jan 2014 17:26:46 -0800 (PST)
In-Reply-To: <1390346208-9207-7-git-send-email-pw@padd.com>
X-Google-Sender-Auth: NmA8Aj7ISUMbPBiuSOd5vW2OK1U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240812>

On Tue, Jan 21, 2014 at 6:16 PM, Pete Wyckoff <pw@padd.com> wrote:
> The tests use author@example.com as the canonical submitter,
> but he does not have an entry in the p4 users database.
> This causes the generated change description to complain
> that the git and p4 users disagree.  The complaint message
> is still valid, just isn't useful in tests.  It was was

s/was was/was/

> introduced in 848de9c (git-p4: warn if git authorship won't
> be retained, 2011-05-13).
>
> Fix t9813 to use @example.com instead of @localhost due to
> change in p4_add_user().  Move the function into the git p4
> test library so author can be added at initialization time.
>
> Signed-off-by: Pete Wyckoff <pw@padd.com>
