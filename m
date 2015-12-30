From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Segfault in git reflog
Date: Wed, 30 Dec 2015 13:28:06 +0100
Message-ID: <1451478486.9251.11.camel@kaarsemaker.net>
References: <20151230092400.GA9319@spirit>
	 <1451474248.9251.7.camel@kaarsemaker.net>
	 <CACsJy8CoRs8dNPWag-E947oVTt4R8XbKBLvaQvBPGm4jqZBKNw@mail.gmail.com>
	 <CACsJy8Cm6a2FiyZwXsTpzbp7ZkZUGWf=HmjsMtQvJMjzVLkTzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 13:28:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEFrS-0005cp-UH
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 13:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763AbbL3M2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 07:28:11 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34871 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754619AbbL3M2J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 07:28:09 -0500
Received: by mail-wm0-f54.google.com with SMTP id f206so36055655wmf.0
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 04:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=XE+nKRi/shU71veBVCHKV1DxEuYi3dWKyeQ6xNqhBDM=;
        b=AdsHu9GJpGcqRob+vjg3wzt/ETSFYv6+XZK7bPLJSpV4O9lH18Rphx36xRFSycdaIl
         K5F+z89UhI3MGC+P2i8imaur89kdwIHa5sa/zco/TIeKw7iKXXWBrCcIfEXkudeDoVMK
         /zKQZSMJPdpvpJVyY6DeigU+EEo9CbnN3E+TkoIljSaG7vZ4ZqkiHD4S/jBQKMyz3Pcw
         cR6Ah250wXG3V8na3TulbRJtIqF8pUcLGmfxPPzkrGR9dc59I1/y8dCwLkKIhs1mlaJv
         gat0ag6dok3RYYiTaZBB6HG6w6a9sv0YouazhVmwac9VT40GTxOnz327ZvhljdWjmooz
         uAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=XE+nKRi/shU71veBVCHKV1DxEuYi3dWKyeQ6xNqhBDM=;
        b=G5DQsTfUFagZBmuyTKAivH8ax6QBphxsHoDNPxFTr6DC8S5TWIXJo6D4Nsfy7FCElw
         KXGuwxuMZJGaEBP1RX+3eY2bB/J5vRiLJGtWhoD1CXTSBUCBOiRtxIOrqL1iUWbAMu0f
         Mj9dM/Ijzt3Cp7SN4hwFsg6vzlFSP5nnj6DX9r8mGxNuXHe0zLpwhKU4N0mynQVDSszs
         zA0A0Yx2zScnPByqOX9fymbAKSrfoVW8iQQdbGJpO8W84jJUzSMbHjtYLQwdBqhVNWaj
         eX5j2M5ozrH4aXeNJ5tFEhJm+jX6gBWMdsDybAP0LdelWAkt7eeqvUpyUKBB0A89kqGp
         JAAg==
X-Gm-Message-State: ALoCoQlN/Fop4jrWkLFgI+e3maIXQduWBLmmNPLG7omxXb0ZoQrP/UBYi36pT/OyUr7ejiXQnJ+gGjMMrRlhuXtxv4dOxQNIBA==
X-Received: by 10.194.204.232 with SMTP id lb8mr83700196wjc.112.1451478488229;
        Wed, 30 Dec 2015 04:28:08 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id un6sm65279908wjc.34.2015.12.30.04.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Dec 2015 04:28:07 -0800 (PST)
In-Reply-To: <CACsJy8Cm6a2FiyZwXsTpzbp7ZkZUGWf=HmjsMtQvJMjzVLkTzA@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283179>

On wo, 2015-12-30 at 18:28 +0700, Duy Nguyen wrote:
> On Wed, Dec 30, 2015 at 6:26 PM, Duy Nguyen <pclouds@gmail.com>
> wrote:
> > On Wed, Dec 30, 2015 at 6:17 PM, Dennis Kaarsemaker
> > <dennis@kaarsemaker.net> wrote:
> >> On wo, 2015-12-30 at 10:24 +0100, Dennis Kaarsemaker wrote:
> >>> spirit:~/code/git (master)$ cat .git/logs/HEAD
> >>> 2635c2b8bfc9aec07b7f023d8e3b3d02df715344
> 54bc41416c5d3ecb978acb0df80d57aa3e54494c Dennis Kaarsemaker <
> dennis@kaarsemaker.net> 1446765642 +0100
> >>> 74c855f87d25a5b5c12d0485ec77c785a1c734c5
> 54bc41416c5d3ecb978acb0df80d57aa3e54494c Dennis Kaarsemaker <
> dennis@kaarsemaker.net> 1446765951 +0100  checkout: moving from
> 3c3d3f629a6176b401ebec455c5dd59ed1b5f910 to master
> 
> Ah... I came from a different angle and did not realize the tag sha1
> is from your reflog. So yeah maybe reflog parsing code should check
> object type first, don't assume it's a commit!

Something like this perhaps?

diff --git a/reflog-walk.c b/reflog-walk.c
index 85b8a54..cd538dd 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -25,6 +25,14 @@ static int read_one_reflog(unsigned char *osha1, unsigned char *nsha1,
 {
        struct complete_reflogs *array = cb_data;
        struct reflog_info *item;
+       struct object *obj;
+
+       obj = parse_object(osha1);
+       if(obj && obj->type != OBJ_COMMIT)
+               die(_("Broken reflog, %s is a %s, not a commit"), sha1_to_hex(obj->oid.hash), typename(obj->type));
+       obj = parse_object(nsha1);
+       if(obj && obj->type != OBJ_COMMIT)
+               die(_("Broken reflog, %s is a %s, not a commit"), sha1_to_hex(obj->oid.hash), typename(obj->type));
 
        ALLOC_GROW(array->items, array->nr + 1, array->alloc);
        item = array->items + array->nr;

That gives me:
fatal: Broken reflog, 74c855f87d25a5b5c12d0485ec77c785a1c734c5 is a tag, not a commit

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
