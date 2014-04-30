From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: Pull is Evil (was: Re: A failing attempt to use Git in a
 centralized environment)
Date: Wed, 30 Apr 2014 11:47:02 -0500
Message-ID: <536129068cc28_1404fdd310fd@nysa.notmuch>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
 <xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
 <536106EA.5090204@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 18:57:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfXpJ-0007pu-2K
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 18:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945914AbaD3Q5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 12:57:41 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:35876 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758884AbaD3Q5k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 12:57:40 -0400
Received: by mail-yh0-f43.google.com with SMTP id f10so1897660yha.2
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 09:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=2qOnCej9d8Pd6In2RgbbadDqNlUZNsH7NTS2pqZJNlI=;
        b=O70oEsD1ImM7preR1+EuANQ9P7O1guRjAzUvRNHvzDgZcvydA6+daINBMNwVTBGTOJ
         6yycI70t8To/Bvng/5+CCnDMPSpobv1aICKDgBMEnHXfu5bbwwb4jE3rMus8CqbVY05p
         jDDYc4SWoxzRE6qUi7wZHFigBqzApheJzZ1qJIBVki4+jLNilS9edIK6hlkUGfI6S+l3
         boN9KCVNkoZgbfxBgSlMnYYbphtiWxr+FF5nDm0+zGOChdFFp7ZJ50jUm5THitDuNanO
         C6wEPlq8gbOubx0/A+VZeZtZ4sj9oDCGQdNloquYYr970FSphvlAK+KmPRb8R5aTsTRX
         4kQQ==
X-Received: by 10.236.92.210 with SMTP id j58mr7305126yhf.5.1398877059928;
        Wed, 30 Apr 2014 09:57:39 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id s26sm43805466yhg.4.2014.04.30.09.57.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 09:57:38 -0700 (PDT)
In-Reply-To: <536106EA.5090204@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247744>

Marc Branchaud wrote:
> But I'm definitely biased because I think pull is pretty much broken:
> 
> * New users are encouraged to use pull, but all too often the default
> fetch-then-merge behaviour doesn't match their expectations and they end up
> starting threads like this one on the mailing list.

Yes, this has been discussed many times in the past, and everyone agrees
the default behavior is not correct.

Most people agree it has to be changed.

And we have patches for it[1].

But it's not going to change. Why? No reason given, it's just not going
to.

> * If we change pull's default behaviour, we'll just be shifting the
> mismatched expectations onto the other half of the new users who would be
> happy with fetch-then-merge.

Not true. As it has been agreed in the discussions, very few people
would be affected negatively by this change, and even then an
appropriate error message like:

  The pull was not fast-forward, please either merge or rebase.
  If unsure, run 'git pull --merge'.

Should do the trick.

[1] http://article.gmane.org/gmane.comp.version-control.git/247567

-- 
Felipe Contreras
