From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 11/11] update_ref(): improve documentation
Date: Mon, 9 Feb 2015 10:51:48 -0800
Message-ID: <CAGZ79kZA-z6OsSE7hb9N1taDh2K6zaK_=P67zNo0G9OSric=8g@mail.gmail.com>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
	<1423412045-15616-12-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 09 19:51:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKtR3-0001I8-QV
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 19:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933109AbbBISvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 13:51:50 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:42202 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759227AbbBISvt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 13:51:49 -0500
Received: by iery20 with SMTP id y20so10373500ier.9
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 10:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ppbNEmkvM7cGoi1ESJekWAkQ06Ga5Nu49iadgGJ41Pc=;
        b=BQ+uVAi9EWGlJUZNOz6yx/4SnJC3zvTbL2JPyArnzrVIAZq0etIRGk8e/5QTifxe7j
         PmTL/En5h4VOkFazim42XRgcUCGt+vasYvsyaLwy638ZchTR5JeMHWgJYOm3APuI4p+l
         Xgzn7UOZ56cHZCzoAvn8NAZZtt9X5c+S1Jda14BAA/6jqe7H8weYg2EKLHV77AD9zK2G
         VyN1qlwBgF08MMKSF9NeD9PQ0cmk63FgAJNg1BCY2eoUN+IV7yv2Pmwg3Fm2JxiUWJar
         guqWUX0nlz0slRgYHiMVbMkRGBLITYZ6U5xzG4yeOH5aZ+7HprmfgmrKQRQgFfWPmj2g
         NsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ppbNEmkvM7cGoi1ESJekWAkQ06Ga5Nu49iadgGJ41Pc=;
        b=PuUA+Gr+FJ0+Yf6MGVyStuPQMBltHXsyfAQXNqT+ofgHHuOiR3gKXrvUqVrPp9kJ1h
         4CwurrKvHAFa4Ee0OktlmlDSOAAebI2s4KFHB2WHirkJ/e6P72TosLbee0rF0xxzjm+U
         xjU/KUdNwRfRusgaoDv+PjOgWSDIAHXvvnt8/OlkKE4eZQQ+MwzrQshrDqe8/6gzSUv6
         UjDBcIV8T6sNUvD5AOy0dA1gf9Ruuvgfhkj/1eieo+ikiJArEqjFM1eGZW2qbXLPMN9K
         L+EeEK0Kn5yDsHlxWUK9yrxPRGY/GDD5SpW9u9PLuOVeeEfkNSpO8dCfPnxNSA7vZjCt
         W8eA==
X-Gm-Message-State: ALoCoQk1YP5DdFOPBSO/jnkusLyTbxoZanKeYgXxOMRcIgGgF9XDr82a92aVYQW1+WMpD1cNyNsB
X-Received: by 10.42.207.129 with SMTP id fy1mr26449220icb.17.1423507908724;
 Mon, 09 Feb 2015 10:51:48 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Mon, 9 Feb 2015 10:51:48 -0800 (PST)
In-Reply-To: <1423412045-15616-12-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263582>

On Sun, Feb 8, 2015 at 8:14 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Add a docstring for update_ref(), emphasizing its similarity to
> ref_transaction_update(). Rename its parameters to match those of
> ref_transaction_update().
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Reviewed-by: Stefan Beller <sbeller@google.com>
