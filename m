From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git push race condition?
Date: Mon, 24 Mar 2014 15:44:20 -0700
Message-ID: <xmqqob0vnrnf.fsf@gitster.dls.corp.google.com>
References: <CAAyEjTN53+5B9Od9wW698wODNL3hR6Upot8-ZLwEksn3ir_zjA@mail.gmail.com>
	<vpq61n3bcve.fsf@anie.imag.fr>
	<CAAyEjTNPqPHswbrrV9pRyXUUqD8dYzJaXQpWr+g3kuBERNLMRw@mail.gmail.com>
	<vpqa9cf9rkv.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Sandler <scott.m.sandler@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:44:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSDbe-0004iY-13
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 23:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbaCXWo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 18:44:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50030 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbaCXWo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 18:44:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D123F770CA;
	Mon, 24 Mar 2014 18:44:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aelSVhaXUdRvwLUZrwiK+4MnyhM=; b=TL8UtW
	RPp45q575S+SlfPcqr6/n29X98GOObrQQ/ysrBqJqjZt6EeskDt7Bajjd+MaEP0h
	JXdkWIjrf9q68N03denQ9ZTJYbfTvbYIuCkFDyyUD7zdyUxCU/y3+IqDfQscjO2x
	kX7K8gJ+wAnz48Nt++vHiy4X0BXi0lMJs+WQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hy4WLXYCezepTzOe7FTnVAM2Evn8W9nT
	uCt7XM2qpIldtNrOb3B2S19B6mP4INnXXmfDyQuOMbqkNIjd+28PNS7+BVMdhu4G
	EvOtNeAvysfuwsb01ZqFv7jETyycfTGMqmNSHnwhwec2oiN64h6jcfLkikRyLAx1
	BAaIxz5cdas=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC055770C9;
	Mon, 24 Mar 2014 18:44:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1306D770C8;
	Mon, 24 Mar 2014 18:44:25 -0400 (EDT)
In-Reply-To: <vpqa9cf9rkv.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	24 Mar 2014 23:09:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D97A49A6-B3A5-11E3-AA7C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244893>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> What you describe really looks like a force-push, or a hook doing a ref
> update (e.g. a hook on a dev branch that updates master if the code
> passes tests or so).

... or a filesystem that is broken.  But I thought this is just a
plain-vanilla ext4, nothing exotic, so....  Puzzled.
