From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Paginate project list
Date: Wed, 14 May 2008 09:59:54 +0200
Message-ID: <200805140959.58263.jnareb@gmail.com>
References: <200805011220.58871.jnareb@gmail.com> <8c5c35580805131230p37953e33he97803c0609012fa@mail.gmail.com> <200805140128.40853.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"John Hawley" <warthog19@eaglescrag.net>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 10:01:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwBv7-0006RO-PN
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 10:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419AbYENIAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 04:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754345AbYENIAM
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 04:00:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:51015 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096AbYENIAL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 04:00:11 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2449495fgg.17
        for <git@vger.kernel.org>; Wed, 14 May 2008 01:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=XQyLciNvpSPYGHUol5ONaA7TFNDzapXOXwRqn6gstTE=;
        b=odH/eUS6rOYdsjEquSCFPan/s97dexy8M0uZOpM5r+GgXfKW7kyNX+L4pkYQbHj/8RFTzdvAvL+YTPij8n5eCElIP8iywReLwBF2NW+VxZMOnoqFzLkb0AjbO1pwTePO1bnNyrb8EVNu4x5EoidfQSvgEt5UzksKMMAOpFQ+BZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=T2akGNDiAFNG12jJkUOfrK31YHfr7cq1lBBPb9SQCIOsOziR1wYo8jO6hwsRy3gYMgLIf/UNdL/y9KnqYq+CYi644Z5K1XpUxMF0zH8pY4ETyBIXLcemVloSTXHFwZDSj1kseBwMfk/f25okvPy6KIIQbfiO7D845RBRtmquGkk=
Received: by 10.86.33.19 with SMTP id g19mr892104fgg.69.1210752009349;
        Wed, 14 May 2008 01:00:09 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.222.61])
        by mx.google.com with ESMTPS id d4sm818019fga.4.2008.05.14.01.00.06
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 May 2008 01:00:07 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200805140128.40853.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82084>

On Wed, 14 May 2008, Jakub Narebski wrote:
> On Tue, 13 May 2008, Lars Hjemli wrote:

>> Another (less accurate) alternative is to stat one or more of
>> packed-refs and refs/heads/*; cgit uses both of these alternatives to 
>> avoid hitting the repo (i.e. object-db) when the project list/search
>> page is generated.
> 
>                                              [It] doesn't hit the 
> object-db, but it hits I/O (perhaps very slightly); and the second 
> solution is what we can pursue for gitweb in addition to caching data.

NOTE, NOTE, NOTE! This changes _semantics_ from "Last Change"
(i.e. commit date of latest commit), to "Last Update" (when latest
batch of objects arrived at given repository).

-- 
Jakub Narebski
Poland
