From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Mon, 10 Jun 2013 11:55:58 +0530
Message-ID: <CALkWK0kvSvK=bFJo13=yw+2EZmGyv46_DUEZaniYGCe7D_V2wg@mail.gmail.com>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org> <20130607000006.GA25731@goldbirke>
 <CALkWK0=D7sHLgptWkFHma1FoS-zdifHqXnuuBKhkyuszgEJ0Xw@mail.gmail.com>
 <7v8v2lu5ks.fsf@alter.siamese.dyndns.org> <20130607191643.GA31625@goldbirke>
 <7vwqq5snzi.fsf@alter.siamese.dyndns.org> <20130607204430.GD31625@goldbirke>
 <7vk3m5si4h.fsf@alter.siamese.dyndns.org> <20130608001147.GA32350@goldbirke> <7v1u8bouam.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 08:26:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlvZ8-0008Da-UT
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 08:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372Ab3FJG0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 02:26:41 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:48680 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab3FJG0j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 02:26:39 -0400
Received: by mail-ie0-f178.google.com with SMTP id at1so11524099iec.37
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 23:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=s/Yaqki7qqx0uur6wJeFEt2jQRfZBGgIsUy4w4xcuxQ=;
        b=bsd4ChwZnERNPkDwMOBItTG1YowH/7p3PHLzdyWx8mnyec1qKYS0z4z+U2snXNvrMY
         O8xoKVczs7V+dZNxTEWFYYFl9Q6H/WiN1DsckP4XLDGpTsINFQQSEXwEnyw1KW6GxAle
         YusD5ZkbhvOgpGurOj+7WYEYjB0VySWstPkA67mtb6yET0yFl6PksOzbtfawXbo/BSoX
         Fb7cBwn9hIe2Xikhbgitw0hV+WBgwXnSjjWblWBJmTfy6zho4Cs5CM9jOqg/pd8mAMBG
         dae7QbLb1ypGIUzzrNpcUX6chN1qfIIMAB+Kx37W7fMvBt7q9q0wqiTwP+TjE7P6+1Dq
         vR9Q==
X-Received: by 10.50.154.106 with SMTP id vn10mr1306423igb.0.1370845599373;
 Sun, 09 Jun 2013 23:26:39 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sun, 9 Jun 2013 23:25:58 -0700 (PDT)
In-Reply-To: <7v1u8bouam.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227243>

Junio C Hamano wrote:
>     Revert 77c1305 and 3c3b46b

The core of the argument seems to be that
__git_complete_revlist_file() is a misleading name for the completion
done by archive and ls-tree, but __git_complete_file() is somehow a
less misleading name?  Irrespective of what the valid completions of
the various commands are, I want to know which completion function
will be _used_ when I'm reading the script.  And that is
__git_complete_revlist_file().

To me, it looks like mega-bikeshedding; a huge amount of time and
effort going behind a non-functional variable rename (and the best
part? the rename isn't getting us a "better" name; just a "historical"
name).  But whatever.
