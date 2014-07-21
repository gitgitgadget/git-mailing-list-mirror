From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation: fix missing text for rev-parse --verify
Date: Mon, 21 Jul 2014 16:14:38 -0700
Message-ID: <20140721231438.GZ12427@google.com>
References: <1405983635-77468-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 01:14:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9Mn8-0007tI-IE
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 01:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbaGUXOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 19:14:43 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:47299 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbaGUXOm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 19:14:42 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so10708695pad.35
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 16:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3Q59wUUxoEeeov/Pv5ILJ4oiCoaj+sNE/AOj3+cElz0=;
        b=qxCJLAaUYvhp8uCxnBFY1kevdryXTe7LkWO+Fhz4gwhLFujI/VB52DTl1LhUwMNJvz
         bzMYvAUsPFhTsUOsozV7LT99JA/hoXbuZfpzinDBXeM4Tu/bT966RRRd1/DZnJhFDpHA
         HdKIDDX/nYoSNxFe1dbAWmnqDvgZUFdEtvc2FavvFV2PdXtxNt3dLvE8MM6aEWvWj5tx
         +Jfs2MWX9FmnHPHCwtMYeF/N+TD6OBd6C2jRfJGDDydBa3NpTomN2eltLOif2lBuW2vh
         zN76eQRLXbIh2SJ03hq0mgbTZgUpIEIh4EVw6wWr6i6rJwrRSsAPbZOT3GEIcgDoeBTr
         BTVA==
X-Received: by 10.68.220.70 with SMTP id pu6mr28425068pbc.15.1405984481758;
        Mon, 21 Jul 2014 16:14:41 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:fd80:2b37:9ae4:f603])
        by mx.google.com with ESMTPSA id q7sm20652960pdm.17.2014.07.21.16.14.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Jul 2014 16:14:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1405983635-77468-1-git-send-email-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254002>

brian m. carlson wrote:

> The caret (^) is used as a markup symbol in AsciiDoc.  Due to the
> inability of AsciiDoc to parse a line containing an unmatched caret, it
> omitted the line from the output, resulting in the man page missing the
> end of a sentence.

Wow.  Usually asciidoc is more forgiving than that.  Are there other
pages affected by this too (e.g., "the commit HEAD^" in
user-manual.txt)?

[...]
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -102,7 +102,7 @@ eval "set -- $(git rev-parse --sq --prefix "$prefix" "$@")"
>  +
>  If you want to make sure that the output actually names an object in
>  your object database and/or can be used as a specific type of object
> -you require, you can add "^{type}" peeling operator to the parameter.
> +you require, you can add "\^{type}" peeling operator to the parameter.

Does using {caret} for ^ work, too?  Generally in asciidoc using a
backslash to escape delimiter characters leads to trouble when the
number of delimiters changes or the text is copy+pasted, since in a
context where the backslash is unneeded it ends up being rendered as a
literal backslash.

Alternatively, does "`^{type}`" work?

Thanks,
Jonathan
