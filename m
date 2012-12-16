From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/4] cache-tree: fix writing cache-tree when CE_REMOVE is present
Date: Sun, 16 Dec 2012 02:38:40 -0800
Message-ID: <80fec1df-83ec-4634-b06e-27369949af94@email.android.com>
References: <1355631328-26678-1-git-send-email-pclouds@gmail.com> <1355631328-26678-4-git-send-email-pclouds@gmail.com> <7vk3siqx8b.fsf@alter.siamese.dyndns.org> <CACsJy8DgwQ2jn=tPpE8f22JNE1Vih86d=Xf1iGBznLcwMukd+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 11:39:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkBdC-0008OQ-IS
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 11:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab2LPKjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 05:39:22 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:57417 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458Ab2LPKjV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 05:39:21 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so2296877dak.19
        for <git@vger.kernel.org>; Sun, 16 Dec 2012 02:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:user-agent:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=ZUreStGhFHte5GJt81yNIuHig5ZhPv1rg371O/PefgM=;
        b=gIlwibQ1U2AulB4eDMCLh++smu1BEb2UbHiOormmXLG0Myi5O7xkTFuyURd4/WYXGw
         yRT/scNw78I8nmo3c+MQOqiSU5gxUTHman+9Pz8qqEOwGqs+gAZp/KslM/F4tg7m8Toz
         BpJaSRqLGFXYLXJlziReKDTOckapo2tLEp/vGOvAD+rTyM5DyBm/c8yh6LZs7HZ5plk8
         P+F//QrvG87i1GDy18kL9FlAtY3rqR27+qw9DZIpWEdfQG7zHEu7JI/YJ6DfLuGnoYx+
         lbI6YCyC4AxcohkUrvQVlSB441ohs83vkujqUtYe4cymjiFuN5FGGJdoVUt9+vsfq6jj
         c+AQ==
Received: by 10.68.197.197 with SMTP id iw5mr32707746pbc.22.1355654360644;
        Sun, 16 Dec 2012 02:39:20 -0800 (PST)
Received: from [192.168.2.111] (c-98-234-214-94.hsd1.ca.comcast.net. [98.234.214.94])
        by mx.google.com with ESMTPS id us7sm6197823pbc.40.2012.12.16.02.39.19
        (version=SSLv3 cipher=OTHER);
        Sun, 16 Dec 2012 02:39:19 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <CACsJy8DgwQ2jn=tPpE8f22JNE1Vih86d=Xf1iGBznLcwMukd+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211588>



Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:

>On Sun, Dec 16, 2012 at 2:20 PM, Junio C Hamano <gitster@pobox.com>
>wrote:
>> Nicely explained.  I wonder if we can also add a piece of test to
>> the patch 4/4 to demonstrate the issue with CE_REMOVE entries,
>> though.
>
>A hand crafted one, maybe. I did not attempt to recreate it with git
>commands (and I don't think we update cache-tree after unpack_trees).

Yeah, that's what I thought. No need to bother creating a bug that won't appear in the real life :-) 

Tusks for sanity checking.
-- 
Pardon terseness, typo and HTML from a tablet.
