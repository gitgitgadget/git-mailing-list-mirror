From: Ryne Everett <ryneeverett@gmail.com>
Subject: Fsck configurations and cloning.
Date: Sat, 5 Mar 2016 20:44:38 -0500
Message-ID: <CAGbFckZNpy=2P8kpSsEpCeTFmgzE5MEK7fnS8xJzDSPJs3iJdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 02:44:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acNkS-0005Pt-V7
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 02:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbcCFBok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 20:44:40 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34914 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbcCFBoj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 20:44:39 -0500
Received: by mail-wm0-f46.google.com with SMTP id l68so39743989wml.0
        for <git@vger.kernel.org>; Sat, 05 Mar 2016 17:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=Jbpbm464l+Xd9gA15e8akWTXGp9n2WKQtuP0ngFzV5Q=;
        b=lmuUNdemJTM5e78W4ChaF/a8Hbc2Oceg6wQ+yNNQ9duuOGuA/jzWZgJq3d8eO0D8Ci
         Z8mWIWN7iiN3lFZC/H+dzws4I4xr24JtEyph7NKLZblOm7CmuRptmK88/8xwTLJ4IxcL
         7HHDKcF9Gby0tuLbkzSTvLS+ZQAvrSIS5ZtDBi2nrJbbFzakDOInqE3QuY45ls30jbEw
         J+VOmbgwNgq4u4yBVlkuxZ836EK1POXOpiirK8RwH91od86c4QOaJQTVP2vppYg328lv
         5WMZ67Pd2f7kDUbLA6EkIMfekozKBrwf4JhCH4yv7CJKaUvB57mXDpKdVPcS3oYqU7Dg
         SLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Jbpbm464l+Xd9gA15e8akWTXGp9n2WKQtuP0ngFzV5Q=;
        b=MbO2yrx/ItqVHPeljVdg3NFClVagDev2gFZ7ssJi2CRu3sOnduEI0Sarug0TfWLmiv
         ZLObcqW/RrEfT1qkiQQD/dhtlCHLBjX/Nwt4xEE82PqhZXZb4jTTHCJSGpWgvuYwlryC
         /apvzRgxcdYysc+kfx3E8+PQM81VlQLI45GAfMQ36r+1nCNaaoPtAiGls0pQueXe9rrk
         2wuNRU723ZDDFMM/bSB1G+oBjRrpIbeEgSw9kstOyuBGhCQQOiXVSedtQq8iwlzb/mvR
         mgRNB7y9WOdzx5YeQqAwuZuSmLPN2QsK2wjVSrlp30+WIJnWpvb+7BCKu2ekbjmE1u3h
         6f5w==
X-Gm-Message-State: AD7BkJJGBNCJuvAHtpWQP4jS4R+z9CTxwFI52W7kR58xQir7n1wfEV1ainIB1rYdxegUniASDcKCTsOlnjhwVg==
X-Received: by 10.28.9.19 with SMTP id 19mr5973384wmj.87.1457228678274; Sat,
 05 Mar 2016 17:44:38 -0800 (PST)
Received: by 10.28.16.15 with HTTP; Sat, 5 Mar 2016 17:44:38 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288336>

I'm assuming fsck configurations are supposed to apply to clones but
I'm having no luck:

    $ git --version
    git version 2.7.2
    $ git config --get transfer.fsckobjects
    true
    $ git config --get fsck.badTimezone
    ignore
    $ cat $(git config --get fsck.skiplist)
    5e6ecdad9f69b1ff789a17733b8edc6fd7091bd8
    $ git clone https://github.com/kennethreitz/requests.git
    Cloning into 'requests'...
    remote: Counting objects: 16904, done.
    error: object 5e6ecdad9f69b1ff789a17733b8edc6fd7091bd8:
badTimezone: invalid author/committer line - bad time zone
    fatal: Error in object
    fatal: index-pack failed

Am I doing something obviously wrong here?
