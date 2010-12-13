From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/19] tree_entry_interesting(): optimize fnmatch when
 base is matched
Date: Mon, 13 Dec 2010 10:10:17 -0800
Message-ID: <7v4oah35o6.fsf@alter.siamese.dyndns.org>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-14-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 19:10:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSCr7-0000Ws-KM
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 19:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758649Ab0LMSK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 13:10:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59328 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758556Ab0LMSKY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 13:10:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 101ED2F31;
	Mon, 13 Dec 2010 13:10:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ZRJFbwSsnzzuvV+BaOMhH+09ZvY=; b=WNyY0gPKhwdHqT1UAVTm0N0
	V87t+PgWeu1QUhQzntQ5B9KR7LBDu7JhF8lnl4Y5R/dpfH46ZkKONKhYeOMxKU/P
	0cJW76PZT5JBBv5VGfgCG36vFJ4TvLlJaDqtXJYOPwLWEYNKkfz2rwosh/Abdr8X
	dY5FBKMSRUeanPna7gKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Br8fIkRKeS4YnvZ9Eo6gH8kLv72zZE2G79BUcSUaMfS3Fs127
	wNgSu+nmOeAqPj47PmeHq4SpQ7AHiGUkF3PL5BgnpsX7SO62rBFcH0eOcEsnWRHT
	5z52cbLrnCz+5biUJ1iWJDxHu0JGGx0WkqtcAnf8rykzHiIF0/hVuFFB9c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C9DFB2F2F;
	Mon, 13 Dec 2010 13:10:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D72DD2F2D; Mon, 13 Dec 2010
 13:10:44 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4F8A5E82-06E4-11E0-8C3D-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163574>

Looks good.
