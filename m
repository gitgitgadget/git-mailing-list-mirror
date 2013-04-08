From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] progress: create public humanize() to show sizes
Date: Mon, 8 Apr 2013 17:55:58 -0400
Message-ID: <CAPig+cSBf1g=cRxBNFA=k_bA1JxUfom5C2gNSjvK=+4BK7D7iw@mail.gmail.com>
References: <CALWbr2wgJmY86Fic-eE9AbtP=HMPddTO=LDp5RGYmt6_kFawpg@mail.gmail.com>
	<1365445101-10425-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 23:56:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPK2m-0000K9-L9
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 23:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936399Ab3DHV4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 17:56:00 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60395 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936362Ab3DHVz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 17:55:59 -0400
Received: by mail-lb0-f174.google.com with SMTP id s10so6246952lbi.33
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 14:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=gCbeWqjY/XEMfhThOK+/boIVrlnzJ5RloT002sLyBZ4=;
        b=0sBq5wid0jn9gPKj0f0hqgoMwWe8MKrrImoBSMIYOUE89vt6acT0PWRkQlUVbu1hA7
         UwrNVfOUMRRUV2BOTlzd+D+ls0+E+m5ZJPI8ldJZcEgj1Tmo9P8p634AKo5RP4EEBlG2
         NsmGA9IZk3cPwJXyb4sy4sVL+xYi+aDLzeGYUz9tbxndc3QtBidEoz9OCxiCaIGyP2vJ
         ynEDvpa9wRW0Lro/h5grnuC0nrL2QZxBk662CibRLWnv80IlXkk4pErkokuKhJn0mrDs
         nzsT8KDZMEtgx+O+8I+6PcuDQ4hMHYuIiljgOhcxmsic0tAmU3D7P+jELEqZg6XcN6yk
         UeTA==
X-Received: by 10.112.75.197 with SMTP id e5mr6900316lbw.6.1365458158172; Mon,
 08 Apr 2013 14:55:58 -0700 (PDT)
Received: by 10.114.174.104 with HTTP; Mon, 8 Apr 2013 14:55:58 -0700 (PDT)
In-Reply-To: <1365445101-10425-1-git-send-email-apelisse@gmail.com>
X-Google-Sender-Auth: 1LhhWW-qIOiTX3KP3RFxgaeEqRg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220527>

On Mon, Apr 8, 2013 at 2:18 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> Currently, humanization of downloaded size is done in the same function
> as text formatting. This is an issue if anyone else wants to use this.
>
> Separate text formatting from size simplification and make the function
> public so that it can easily be used by other clients.
>
> We now can use humanize() for both downloaded size and download speed
> calculation. One of the drawbacks is that speed will no look like this

s/no/now/

> when download is stalled: "0 bytes/s" instead of "0 KiB/s".
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
