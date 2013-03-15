From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1 10/45] parse_pathspec: a special flag for max_depth feature
Date: Fri, 15 Mar 2013 17:28:59 -0400
Message-ID: <CAPig+cQi6p=cbQzLFhauy-0ccknpVyV-uF6pZURvObPyS2w6OQ@mail.gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
	<1363327620-29017-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 15 22:29:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGcBu-0007J6-5d
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 22:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700Ab3COV3C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 17:29:02 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:57532 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932685Ab3COV3B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Mar 2013 17:29:01 -0400
Received: by mail-lb0-f179.google.com with SMTP id j14so3182073lbo.38
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 14:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Yysuhuj4ZTAqBHvcLAaSedhfznaiDb00iAHmncOatMc=;
        b=G4Sx2VE41KlGAwa4HZ5Q1eod614NacUUacrVL6JUo9ZvAa2U9E/I2MfKheX0/IYte7
         rl8YnDUS1KlAFChYm9pG0JW5IULF9x7uKb2eJhenyrQDZNwfb/0WkzCyVhY2UoOhBlom
         4hYT91ZSTUXAicvrd/jz888WNsa73ikpon23T7PpBpBxFaVp5x+CBa3x5+4rOmXY5+ld
         ji8j71oXEsdVN+d2iXZS6Iqy0CKoyODR5kI3wBnpVQ+r5XNUDN2MO3VT6Kt7mWbmdb96
         zWBbn9vJOEfkZud+zD8Z3m0eiquLuCbqS3uIb+zQAot/7LmMU9RoHAeUlz5iBc56QWb5
         f2lw==
X-Received: by 10.112.88.35 with SMTP id bd3mr3257043lbb.56.1363382939482;
 Fri, 15 Mar 2013 14:28:59 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Fri, 15 Mar 2013 14:28:59 -0700 (PDT)
In-Reply-To: <1363327620-29017-11-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: VgIISA-pr-ORKoBBrzjAbaE5oWc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218262>

On Fri, Mar 15, 2013 at 2:06 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> match_pathspec_depth() and tree_entry_interesting() check max_depth
> field in order to support "git grep --max-depth". The feature
> activation is tied to "recursive" field, which led to some unwated

s/unwated/unwanted/

> activation, e.g. 5c8eeb8 (diff-index: enable recursive pathspec
> matching in unpack_trees - 2012-01-15).
