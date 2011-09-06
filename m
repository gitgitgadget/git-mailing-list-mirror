From: Junio C Hamano <gitster@pobox.com>
Subject: Re: question about interactive.singlekey
Date: Tue, 06 Sep 2011 14:42:51 -0700
Message-ID: <7vobyx73fo.fsf@alter.siamese.dyndns.org>
References: <20110906205011.GC1747@kudu.in-berlin.de>
 <7vsjo9743o.fsf@alter.siamese.dyndns.org>
 <20110906213326.GD1747@kudu.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>, Git-List <git@vger.kernel.org>
To: Valentin Haenel <valentin@fsfe.org>
X-From: git-owner@vger.kernel.org Tue Sep 06 23:43:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R13Q3-0003Yw-3M
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 23:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189Ab1IFVmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 17:42:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37704 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791Ab1IFVmx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 17:42:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 397CF5DA0;
	Tue,  6 Sep 2011 17:42:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xQEi4z4CZkQGFWPiLnzJ6h6WjzI=; b=dMSUCt
	3s9Qd6u69RozurBElOHea6qnpGjN6KUO4wrSrW6vdXMB/dkIOnTNHUFZneO4STtp
	qYpeeycuyWtS3XRuBbET1UZ1e6fwre8q5lYLkdzcTV9VjOZDzSahpVBQ0seQDSAH
	MPPfl8zkIB+1nbquGFfWAmCvS3D99EdhEJOac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xgh56Uc3gp4+OEP6rSi1C83nlBVNQ3hy
	oCUf5qCuf3uzKe8oZ/Q3D8gKTgNPlJqXnvUsqLo+PU0ErZw75UnFmMMZNgfhy95g
	0XFBRF5oUIwwHanY8LwZYstHiz301rJmEF+3VNkGCxdfvicuM4MND+qG4Qu66TRO
	wUfJXYzF5WM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31D455D9F;
	Tue,  6 Sep 2011 17:42:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD7A05D9E; Tue,  6 Sep 2011
 17:42:52 -0400 (EDT)
In-Reply-To: <20110906213326.GD1747@kudu.in-berlin.de> (Valentin Haenel's
 message of "Tue, 6 Sep 2011 23:33:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C862D3E-D8D1-11E0-9E9A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180840>

Valentin Haenel <valentin@fsfe.org> writes:

>> > ... Does
>> > the 'interactive.singlekey' setting perhaps need additional libraries
>> > which were forgotten in the debian package dependencies?
>> 
>>  ...
>> so perhaps...
>> 
>>     $ apt-cache search term.*readkey
>>     libterm-readkey-perl - A perl module for simple terminal control
>
> Bingo! Thanks! Should i send this downstream somewhere?

It may make sense to add libterm-readkey-perl to Suggests, perhaps, but I
am not a debian maintainer and I am not familiar with the policies to
handle a minor dependencies like this.

$ apt-cache show git | grep Maintainer
Maintainer: Gerrit Pape <pape@smarden.org>
